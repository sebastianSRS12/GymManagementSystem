const express = require('express'); // Import Express framework
const dotenv = require('dotenv'); // Import dotenv for environment variables
const cors = require('cors'); // Import CORS for cross-origin requests
const morgan = require('morgan'); // Import Morgan for logging requests
const { dbConnect } = require('./config/db'); // Import database connection

dotenv.config(); // Load environment variables

const app = express(); // Initialize Express app

// Middleware
app.use(cors()); // Enable CORS for API requests
app.use(express.json()); // Parse JSON requests
app.use(express.urlencoded({ extended: true })); // Parse URL-encoded data
app.use(morgan('dev')); // Log incoming requests in development mode

// Connect to database
dbConnect();

// API routes (Example)
app.get('/', (req, res) => {
    res.send('Server is running on port 5000');
});

app.post('/api/data', (req, res) => {
    const { name, email } = req.body;
    res.json({ message: `Received data for ${name} (${email})` });
});

// Error handling middleware
app.use((req, res, next) => {
    const error = new Error('Not Found');
    error.status = 404;
    next(error);
});

app.use((error, req, res, next) => {
    res.status(error.status || 500).json({
        error: {
            message: error.message,
        },
    });
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running locally on http://localhost:${PORT}`);
});
