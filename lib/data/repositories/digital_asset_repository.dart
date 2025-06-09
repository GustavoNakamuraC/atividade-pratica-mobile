import 'package:api_market_cap_coin/data/datasources/market_data_provider.dart';
import 'package:api_market_cap_coin/domain/entities/digital_asset_model.dart';
import 'package:api_market_cap_coin/domain/repositories/i_digital_asset_repository.dart';

class DigitalAssetRepository implements IDigitalAssetRepository {
  final IMarketDataProvider _dataProvider;

  DigitalAssetRepository(this._dataProvider);

  @override
  Future<List<DigitalAssetModel>> getDigitalAssets(String symbols) async {
    print('DigitalAssetRepository: retrieving digital assets for symbols: $symbols');
    try {
      final result = await _dataProvider.fetchMarketData(symbols);
      print('DigitalAssetRepository: received ${result.length} assets from data provider.');
      return result;
    } catch (e) {
      print('DigitalAssetRepository: Error retrieving digital assets: $e');
     
      rethrow;
    }
  }
}