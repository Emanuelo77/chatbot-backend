const express = require('express');
const cors = require('cors');
const { analyzeStimmung } = require('./stimmunganalyse');
const { uploadToS3 } = require('./S3');

const app = express();

// CORS-Konfiguration
const corsOptions = {
  origin: process.env.FRONTEND_URL || 'http://localhost:3000',
  optionsSuccessStatus: 200
};

app.use(cors(corsOptions));
app.use(express.json());

app.post('/api/chat', async (req, res) => {
  try {
    const { message } = req.body;

    // Hier würde normalerweise die Verarbeitung mit einem KI-Service wie OpenAI stattfinden
    const botReply = `Ich habe Ihre Nachricht "${message}" erhalten.`;

    // Stimmungsanalyse durchführen
    const sentiment = await analyzeStimmung(message);

    // Nachricht in S3 speichern
    await uploadToS3(JSON.stringify({ message, botReply, sentiment }));

    res.json({ message: botReply, sentiment });
  } catch (error) {
    console.error('Error in chat API:', error);
    res.status(500).json({ error: 'An error occurred while processing your request.' });
  }
});

module.exports = app;