const mysql = require('mysql2/promise');

async function dbConnect() {
    try {
        const connection = await mysql.createConnection({
            host: process.env.DB_HOST,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME,
        });
        console.log('Database connected successfully!');
        global.dbConnection = connection;
    } catch (error) {
        console.error('Database connection error:', error);
        process.exit(1);
    }
}

module.exports = { dbConnect }; // Ensure this is correct

