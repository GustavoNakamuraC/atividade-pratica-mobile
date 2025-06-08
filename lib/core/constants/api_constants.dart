class ConstantesApi {
  static const String urlBase = 'https://pro-api.coinmarketcap.com/v2';
  static const String endpointCrypto = '/cryptocurrency/quotes/latest';
  static const String chaveApi = 'SUA_CHAVE_API_AQUI';
  
  static Map<String, String> get headers => {
    "Accepts": "application/json",
    "X-CMC_PRO_API_KEY": chaveApi,
  };
  
  static const List<String> simbolosPadrao = [
    'BTC', 'ETH', 'SOL', 'BNB', 'BCH', 'MKR', 'AAVE', 'DOT', 'SUI', 'ADA',
    'XRP', 'TIA', 'NEO', 'NEAR', 'PENDLE', 'RENDER', 'LINK', 'TON', 'XAI',
    'SEI', 'IMX', 'ETHFI', 'UMA', 'SUPER', 'FET', 'USUAL', 'GALA', 'PAAL', 'AERO'
  ];
}