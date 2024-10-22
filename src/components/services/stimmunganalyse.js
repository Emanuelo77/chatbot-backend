const { TextAnalyticsClient, AzureKeyCredential } = require("@azure/ai-text-analytics");

const client = new TextAnalyticsClient(process.env.AZURE_ENDPOINT, new AzureKeyCredential(process.env.AZURE_API_KEY));

app.post('/api/analyze-sentiment', async (req, res) => {
  const { text } = req.body;
  const results = await client.analyzeSentiment([text]);
  res.json(results[0]);
});