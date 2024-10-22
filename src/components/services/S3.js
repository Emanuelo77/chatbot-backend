const AWS = require('aws-sdk');

const s3 = new AWS.S3({
  accessKeyId: process.env.AWS_ACCESS_KEY_ID,
  secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
});

app.post('/api/upload', (req, res) => {
  const { file, filename } = req.body;
  const params = {
    Bucket: process.env.S3_BUCKET_NAME,
    Key: filename,
    Body: Buffer.from(file, 'base64'),
  };

  s3.upload(params, (err, data) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error uploading file');
    } else {
      res.send('File uploaded successfully');
    }
  });
});