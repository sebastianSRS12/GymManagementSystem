const mysql = requiere('mysql2/promise');

// Database connection
async function dbConnect() {
   try {
    const connection = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME,
   }); 
   console.log('Database connected succesfully!');

   global.dbConnection = connection;
} catch (error) {
   console.exit(1); // Exit process with failure
   }
}
module.exports = {dbConnect};  
