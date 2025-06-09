import 'package:api_market_cap_coin/core/service/network_client.dart';
import 'package:api_market_cap_coin/domain/entities/digital_asset_model.dart';

abstract class IMarketDataProvider {
  Future<List<DigitalAssetModel>> fetchMarketData(String symbols);
}

class MarketDataProvider implements IMarketDataProvider {
  final NetworkClient _networkClient;

  MarketDataProvider(this._networkClient);

  @override
  Future<List<DigitalAssetModel>> fetchMarketData(String symbols) async {
    print('Retrieving market data for symbols: $symbols');
    try {
      final response = await _networkClient.executeRequest(
        endpoint: '/v2/cryptocurrency/quotes/latest?symbol=$symbols&convert=BRL',
      );

      print('Raw API Response: $response');

      if (response != null && response['data'] != null) {
        final Map<String, dynamic> data = response['data'];
        final List<DigitalAssetModel> digitalAssets = [];
        data.forEach((key, value) {
          if (value is List) { 
            for (var item in value) {
              if (item is Map<String, dynamic>) {
                 try {
                    digitalAssets.add(DigitalAssetModel.fromJson(item));
                 } catch (e) {
                    print('Error parsing item for key $key: $item. Error: $e');
                 }
              }
            }
          } else if (value is Map<String, dynamic>) {
             try {
                digitalAssets.add(DigitalAssetModel.fromJson(value));
             } catch (e) {
                print('Error parsing value for key $key: $value. Error: $e');
             }
          }
        });
        print('Parsed ${digitalAssets.length} digital assets.');
        return digitalAssets;
      } else {
        print('No data found in response or response is null.');
        return [];
      }
    } catch (e) {
      print('Error in MarketDataProvider.fetchMarketData: $e');
      throw Exception('Failed to retrieve market data: $e');
    }
  }
}