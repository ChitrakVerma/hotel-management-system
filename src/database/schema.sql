-- Hotel Management System – Database Schema
-- File: src/database/schema.sql
-- Description: Initial table definitions for the Hotel Management System
-- Version: 0.1.0

-- ─── Drop tables in dependency order (for clean re-run) ──────────────────────
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS invoice_items;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS guests;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS room_categories;
DROP TABLE IF EXISTS users;

-- ─── Users (authentication) ──────────────────────────────────────────────────
CREATE TABLE users (
    id          SERIAL PRIMARY KEY,
    username    VARCHAR(100) NOT NULL UNIQUE,
    email       VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role        VARCHAR(50) NOT NULL DEFAULT 'staff',   -- admin, manager, staff, receptionist
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ─── Room Categories ─────────────────────────────────────────────────────────
CREATE TABLE room_categories (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL UNIQUE,   -- e.g., Single, Double, Suite, Deluxe
    description     TEXT,
    base_price      NUMERIC(10, 2) NOT NULL,
    max_occupancy   INT NOT NULL DEFAULT 2,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ─── Rooms ───────────────────────────────────────────────────────────────────
CREATE TABLE rooms (
    id              SERIAL PRIMARY KEY,
    room_number     VARCHAR(10) NOT NULL UNIQUE,
    category_id     INT NOT NULL REFERENCES room_categories(id) ON DELETE RESTRICT,
    floor           INT NOT NULL DEFAULT 1,
    status          VARCHAR(20) NOT NULL DEFAULT 'available',  -- available, occupied, maintenance, cleaning
    description     TEXT,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ─── Staff ───────────────────────────────────────────────────────────────────
CREATE TABLE staff (
    id              SERIAL PRIMARY KEY,
    user_id         INT REFERENCES users(id) ON DELETE SET NULL,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(255) NOT NULL UNIQUE,
    phone           VARCHAR(20),
    department      VARCHAR(100),       -- Front Desk, Housekeeping, F&B, Management
    designation     VARCHAR(100),
    date_joined     DATE NOT NULL DEFAULT CURRENT_DATE,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ─── Guests ──────────────────────────────────────────────────────────────────
CREATE TABLE guests (
    id              SERIAL PRIMARY KEY,
    first_name      VARCHAR(100) NOT NULL,
    last_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(255) UNIQUE,
    phone           VARCHAR(20),
    address         TEXT,
    id_type         VARCHAR(50),        -- Passport, Aadhar, Driving Licence
    id_number       VARCHAR(100),
    nationality     VARCHAR(100),
    preferences     TEXT,
    loyalty_points  INT NOT NULL DEFAULT 0,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ─── Bookings ────────────────────────────────────────────────────────────────
CREATE TABLE bookings (
    id              SERIAL PRIMARY KEY,
    guest_id        INT NOT NULL REFERENCES guests(id) ON DELETE RESTRICT,
    room_id         INT NOT NULL REFERENCES rooms(id) ON DELETE RESTRICT,
    check_in_date   DATE NOT NULL,
    check_out_date  DATE NOT NULL,
    num_adults      INT NOT NULL DEFAULT 1,
    num_children    INT NOT NULL DEFAULT 0,
    status          VARCHAR(20) NOT NULL DEFAULT 'confirmed',  -- confirmed, checked_in, checked_out, cancelled, no_show
    special_requests TEXT,
    booked_by       INT REFERENCES users(id) ON DELETE SET NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT valid_dates CHECK (check_out_date > check_in_date)
);

-- ─── Invoices ────────────────────────────────────────────────────────────────
CREATE TABLE invoices (
    id              SERIAL PRIMARY KEY,
    booking_id      INT NOT NULL REFERENCES bookings(id) ON DELETE RESTRICT,
    issue_date      DATE NOT NULL DEFAULT CURRENT_DATE,
    subtotal        NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    tax_rate        NUMERIC(5, 4) NOT NULL DEFAULT 0.18,     -- 18% GST
    tax_amount      NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    discount_amount NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    total_amount    NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    status          VARCHAR(20) NOT NULL DEFAULT 'pending',   -- pending, paid, partially_paid, cancelled
    notes           TEXT,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ─── Invoice Line Items ───────────────────────────────────────────────────────
CREATE TABLE invoice_items (
    id              SERIAL PRIMARY KEY,
    invoice_id      INT NOT NULL REFERENCES invoices(id) ON DELETE CASCADE,
    description     VARCHAR(255) NOT NULL,
    quantity        INT NOT NULL DEFAULT 1,
    unit_price      NUMERIC(10, 2) NOT NULL,
    line_total      NUMERIC(10, 2) NOT NULL
);

-- ─── Payments ────────────────────────────────────────────────────────────────
CREATE TABLE payments (
    id              SERIAL PRIMARY KEY,
    invoice_id      INT NOT NULL REFERENCES invoices(id) ON DELETE RESTRICT,
    payment_date    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    amount          NUMERIC(10, 2) NOT NULL,
    method          VARCHAR(50) NOT NULL,  -- cash, credit_card, debit_card, upi, bank_transfer
    reference_no    VARCHAR(255),          -- transaction or receipt reference
    recorded_by     INT REFERENCES users(id) ON DELETE SET NULL,
    notes           TEXT,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ─── Indexes ─────────────────────────────────────────────────────────────────
CREATE INDEX idx_rooms_status ON rooms(status);
CREATE INDEX idx_bookings_guest ON bookings(guest_id);
CREATE INDEX idx_bookings_room ON bookings(room_id);
CREATE INDEX idx_bookings_dates ON bookings(check_in_date, check_out_date);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_invoices_booking ON invoices(booking_id);
CREATE INDEX idx_payments_invoice ON payments(invoice_id);

-- ─── Seed: Room Categories ───────────────────────────────────────────────────
INSERT INTO room_categories (name, description, base_price, max_occupancy) VALUES
    ('Single',  'Comfortable room for one guest with a single bed',              1500.00, 1),
    ('Double',  'Spacious room with a queen bed, suitable for two guests',        2500.00, 2),
    ('Twin',    'Room with two single beds, ideal for friends or colleagues',     2200.00, 2),
    ('Suite',   'Luxury suite with a king bed, living area, and premium amenities', 6000.00, 3),
    ('Deluxe',  'Deluxe room with premium furnishings and a scenic view',         4000.00, 2);
