require('dotenv').config();
const app = require('./components/services/apiService');

const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});