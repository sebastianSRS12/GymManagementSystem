const { dbConnect } = require('./config/db');

// Connect to database
dbConnect();

// After that, start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running locally on http://localhost:${PORT}`);
});
