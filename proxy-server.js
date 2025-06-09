const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const cors = require('cors');

const app = express();
app.use(cors());

app.use('/coinmarketcap', createProxyMiddleware({
  target: 'https://pro-api.coinmarketcap.com',
  changeOrigin: true,
  pathRewrite: {'^/coinmarketcap': ''},
  headers: {
    'X-CMC_PRO_API_KEY': '4d4eb837-1819-4653-b77b-b040a3389d9a'
  }
}));

app.listen(3000, () => console.log('Proxy CORS ativo na porta 3000'));