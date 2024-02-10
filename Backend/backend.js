const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Hardcoded data
const houseData = {
    lat: "lat",
    long: "long",
    baths: "1",
    beds: "3",
    squareFeet: 1500,
    year: "1955"
};

// Endpoint to fetch house data
app.get('/fetchHouse', (req, res) => {
    res.json(houseData);
});

// Start server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
