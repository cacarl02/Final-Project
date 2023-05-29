const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());

// Your other server routes and code

app.listen(3001, () => {
  console.log('Server is running on port 3001');
});
