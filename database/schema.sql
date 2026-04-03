SET SERVEROUTPUT ON;
SET LINESIZE 200;
SET PAGESIZE 100;

PROMPT '--- [Initializing Script: Dropping Old Tables to prevent errors] ---';
-- Drop existing tables to ensure a clean run (ignore errors if they don't exist yet)
BEGIN
   EXECUTE IMMEDIATE 'DROP VIEW Guest_Receipt_View';
   EXECUTE IMMEDIATE 'DROP TABLE Payment CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE Booking CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE Contact_Message CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE Room CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE Guest CASCADE CONSTRAINTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

PROMPT '--- [Executing DDL: Creating Tables with Constraints] ---';

-- 1. Guest Table (Replaces Learner)
-- Uses IDENTITY for auto-incrementing Primary Keys
CREATE TABLE Guest (
    guest_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone VARCHAR2(20)
);

-- 2. Room Table (Replaces Course)
CREATE TABLE Room (
    room_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_type VARCHAR2(50) NOT NULL,
    price_per_night NUMBER(10, 2) CHECK (price_per_night >= 0),
    total_bookings NUMBER DEFAULT 0 -- Will be updated by our PL/SQL Trigger
);

-- 3. Booking Table (Junction Table between Guest and Room, replaces Enrollment)
CREATE TABLE Booking (
    booking_id VARCHAR2(20) PRIMARY KEY, 
    guest_id NUMBER REFERENCES Guest(guest_id),
    room_id NUMBER REFERENCES Room(room_id),
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    special_requests VARCHAR2(500),
    status VARCHAR2(20) DEFAULT 'Pending',
    -- Constraint ensures check_out is always after check_in
    CONSTRAINT check_dates CHECK (check_out > check_in) 
);

-- 4. Payment Table
CREATE TABLE Payment (
    payment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id VARCHAR2(20) REFERENCES Booking(booking_id),
    amount NUMBER(10, 2) CHECK (amount >= 0),
    payment_date DATE DEFAULT SYSDATE
);

-- 5. Contact_Message Table (Directly maps to contact.html)
CREATE TABLE Contact_Message (
    message_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sender_name VARCHAR2(100) NOT NULL,
    sender_email VARCHAR2(100) NOT NULL,
    message_text VARCHAR2(1000) NOT NULL,
    submitted_at DATE DEFAULT SYSDATE
);


PROMPT '--- [Executing PL/SQL: Creating Triggers] ---';

-- TRIGGER: Automatically update the total_bookings count in the Room table
-- whenever a new Booking is inserted.
CREATE OR REPLACE TRIGGER update_room_booking_count
AFTER INSERT ON Booking
FOR EACH ROW
BEGIN
    UPDATE Room
    SET total_bookings = total_bookings + 1
    WHERE room_id = :NEW.room_id;
END;
/


PROMPT '--- [Executing DML: Inserting Sample Data] ---';

-- Inserting Guests
INSERT INTO Guest (full_name, email, phone) VALUES ('John Doe', 'john@email.com', '555-0101');
INSERT INTO Guest (full_name, email, phone) VALUES ('Sarah Smith', 'sarah@email.com', '555-0102');
INSERT INTO Guest (full_name, email, phone) VALUES ('Michael Johnson', 'mike@email.com', '555-0103');
INSERT INTO Guest (full_name, email, phone) VALUES ('Emily Davis', 'emily@email.com', '555-0104');

-- Inserting Rooms (Mapping to rooms.html)
INSERT INTO Room (room_type, price_per_night) VALUES ('Standard Room', 3500);
INSERT INTO Room (room_type, price_per_night) VALUES ('Deluxe Room', 6500);
INSERT INTO Room (room_type, price_per_night) VALUES ('Deluxe Room', 6500);
INSERT INTO Room (room_type, price_per_night) VALUES ('Suite', 12000);

-- Inserting Bookings (Using TO_DATE for proper date formatting)
INSERT INTO Booking (booking_id, guest_id, room_id, check_in, check_out, status) 
VALUES ('GH-8492', 1, 2, TO_DATE('2026-04-10', 'YYYY-MM-DD'), TO_DATE('2026-04-15', 'YYYY-MM-DD'), 'Confirmed');

INSERT INTO Booking (booking_id, guest_id, room_id, check_in, check_out, status) 
VALUES ('GH-1029', 2, 4, TO_DATE('2026-04-12', 'YYYY-MM-DD'), TO_DATE('2026-04-14', 'YYYY-MM-DD'), 'Confirmed');

INSERT INTO Booking (booking_id, guest_id, room_id, check_in, check_out, status) 
VALUES ('GH-5531', 3, 1, TO_DATE('2026-04-18', 'YYYY-MM-DD'), TO_DATE('2026-04-20', 'YYYY-MM-DD'), 'Pending');

INSERT INTO Booking (booking_id, guest_id, room_id, check_in, check_out, status) 
VALUES ('GH-9982', 4, 2, TO_DATE('2026-05-01', 'YYYY-MM-DD'), TO_DATE('2026-05-05', 'YYYY-MM-DD'), 'Pending');

-- Inserting Payments
INSERT INTO Payment (booking_id, amount) VALUES ('GH-8492', 32500); -- 5 nights * 6500
INSERT INTO Payment (booking_id, amount) VALUES ('GH-1029', 24000); -- 2 nights * 12000
INSERT INTO Payment (booking_id, amount) VALUES ('GH-5531', 7000);  -- 2 nights * 3500
INSERT INTO Payment (booking_id, amount) VALUES ('GH-9982', 26000); -- 4 nights * 6500

-- Inserting Contact Messages
INSERT INTO Contact_Message (sender_name, sender_email, message_text) VALUES ('Alice', 'alice@test.com', 'Do you allow pets?');
INSERT INTO Contact_Message (sender_name, sender_email, message_text) VALUES ('Bob', 'bob@test.com', 'Late check-in request.');
INSERT INTO Contact_Message (sender_name, sender_email, message_text) VALUES ('Charlie', 'chuck@test.com', 'Wifi password?');
INSERT INTO Contact_Message (sender_name, sender_email, message_text) VALUES ('Spammer', 'spam@test.com', 'Buy cheap crypto here!');

PROMPT '--- [Executing DML: Updates and Deletes] ---';

-- UPDATE: Confirm a pending booking
UPDATE Booking 
SET status = 'Confirmed' 
WHERE booking_id = 'GH-5531';

-- DELETE: Remove a spam message (Safe deletion, no foreign keys attached)
DELETE FROM Contact_Message 
WHERE sender_name = 'Spammer';


PROMPT '--- [Executing PL/SQL: Transactions (Safe Payment Processing)] ---';
-- Demonstrating a transaction block. If the payment insert fails, 
-- it rolls back the status update to ensure data consistency.
DECLARE
    v_booking_id VARCHAR2(20) := 'GH-9982';
BEGIN
    UPDATE Booking SET status = 'Confirmed' WHERE booking_id = v_booking_id;
    INSERT INTO Payment (booking_id, amount) VALUES (v_booking_id, 26000);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction Successful: Booking confirmed and payment processed.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transaction Failed: Changes rolled back.');
END;
/


PROMPT '--- [Executing DQL: Complex Queries] ---';

PROMPT '-- INNER JOIN (3 Tables): Guest names, their Bookings, and Room Type --';
SELECT g.full_name, b.booking_id, r.room_type, b.status
FROM Guest g
INNER JOIN Booking b ON g.guest_id = b.guest_id
INNER JOIN Room r ON b.room_id = r.room_id;

PROMPT '-- LEFT JOIN: Finding all Rooms, including those with zero bookings --';
-- Notice room 3 (the second Deluxe Room) has no bookings associated with it
SELECT r.room_id, r.room_type, b.booking_id
FROM Room r
LEFT JOIN Booking b ON r.room_id = b.room_id;

PROMPT '-- GROUP BY & HAVING: Total Revenue collected per room type --';
-- Only showing room types that have generated more than 10,000 in revenue
SELECT r.room_type, SUM(p.amount) AS total_revenue
FROM Room r
JOIN Booking b ON r.room_id = b.room_id
JOIN Payment p ON b.booking_id = p.booking_id
GROUP BY r.room_type
HAVING SUM(p.amount) > 10000;

PROMPT '-- SUBQUERY: Finding the Guest who made the highest single payment --';
SELECT full_name 
FROM Guest 
WHERE guest_id = (
    SELECT guest_id 
    FROM Booking 
    WHERE booking_id = (
        SELECT booking_id 
        FROM Payment 
        WHERE amount = (SELECT MAX(amount) FROM Payment)
    )
);


PROMPT '--- [Creating Views] ---';

-- VIEW: Simplifies a complex query to generate receipts for guests
CREATE OR REPLACE VIEW Guest_Receipt_View AS
SELECT 
    g.full_name, 
    g.email, 
    b.booking_id, 
    r.room_type, 
    b.check_in, 
    b.check_out, 
    p.amount AS total_paid,
    p.payment_date
FROM Guest g
JOIN Booking b ON g.guest_id = b.guest_id
JOIN Room r ON b.room_id = r.room_id
JOIN Payment p ON b.booking_id = p.booking_id;

PROMPT '-- Selecting from the newly created View --';
SELECT * FROM Guest_Receipt_View;
