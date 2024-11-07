//server.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 300;

app.use.apply(express.json());

// Basic route 
app.get('/', (req,res) => {
    res.send('Node.js backend is up and running!');
});

app.listen(PORT, () => {
    console.log('Server is running on port ${PORT}');
});