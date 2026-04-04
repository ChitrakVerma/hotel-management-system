const express = require('express');
const cors = require('cors');
const oracledb = require('oracledb');

const app = express();
const PORT = 3000;

// Middleware to parse JSON and allow frontend communication
app.use(cors());
app.use(express.json());

// Database configuration (Replace with your actual Oracle credentials)
const dbConfig = {
    user: "SYSTEM",
    password: "Chitrak",
    connectString: "localhost:1521/XEPDB1" // Standard local Oracle XE string
};

// --- API ENDPOINT ---
// This listens for POST requests from your booking.html form
app.post('/api/bookings', async (req, res) => {
    console.log("\n--- NEW BOOKING REQUEST RECEIVED! ---");

    try {
        const connection = await oracledb.getConnection(dbConfig);
        
        // 1. Generate the ID in Node.js instead of Oracle
        const generatedId = 'GH-' + Math.floor(Math.random() * (9999 - 1000 + 1) + 1000);

        // 2. Pass the new :booking_id variable to Oracle
        const insertSql = `
            INSERT INTO Booking (booking_id, guest_id, room_id, check_in, check_out, status)
            VALUES (:booking_id, :guest_id, :room_id, TO_DATE(:check_in, 'YYYY-MM-DD'), TO_DATE(:check_out, 'YYYY-MM-DD'), 'Confirmed')
        `;

        const binds = {
            booking_id: generatedId, // Using the ID we just made
            guest_id: req.body.guest_id,
            room_id: req.body.room_id + 1, 
            check_in: req.body.check_in,
            check_out: req.body.check_out
        };

        await connection.execute(insertSql, binds, { autoCommit: true });
        await connection.close();
        
        // 3. Send the exact message you want, PLUS the real Reference ID
        res.json({ 
            success: true, 
            message: "Booking Confirmed!", 
            referenceId: generatedId 
        });

    } catch (error) {
        console.error("DATABASE ERROR:", error.message);
        res.json({ success: false, message: "Failed to process booking." });
    }
});

// ==========================================
// ROUTE 2: CONTACT PAGE (Saving a message)
// ==========================================
app.post('/api/contact', async (req, res) => {
    console.log("\n--- NEW CONTACT MESSAGE RECEIVED! ---");
    try {
        const connection = await oracledb.getConnection(dbConfig);
        
        const insertSql = `
            INSERT INTO Contact_Message (sender_name, sender_email, message_text)
            VALUES (:name, :email, :message)
        `;
        
        const binds = {
            name: req.body.name,
            email: req.body.email,
            message: req.body.message
        };

        await connection.execute(insertSql, binds, { autoCommit: true });
        await connection.close();
        
        res.json({ success: true, message: "Thank you! Your message has been received." });
    } catch (error) {
        console.error("DATABASE ERROR:", error.message);
        res.json({ success: false, message: "Failed to save message." });
    }
});

// ==========================================
// ROUTE 3: ADMIN DASHBOARD (Retrieving data)
// ==========================================
app.get('/api/admin/bookings', async (req, res) => {
    console.log("\n--- ADMIN DASHBOARD: FETCHING BOOKINGS ---");
    try {
        const connection = await oracledb.getConnection(dbConfig);
        
        // We use the SQL View we created earlier so the data is already perfectly formatted!
        const sql = `SELECT * FROM Guest_Receipt_View ORDER BY check_in ASC`;
        
        // OUT_FORMAT_OBJECT is crucial here—it tells Oracle to send the data back as nice JSON instead of raw arrays
        const result = await connection.execute(sql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });
        
        await connection.close();
        res.json({ success: true, data: result.rows });
    } catch (error) {
        console.error("DATABASE ERROR:", error.message);
        res.json({ success: false, message: "Failed to fetch dashboard data." });
    }
});

// Start the server
app.listen(PORT, () => {
    console.log(`Grand Horizon API Server running on http://localhost:${PORT}`);
});