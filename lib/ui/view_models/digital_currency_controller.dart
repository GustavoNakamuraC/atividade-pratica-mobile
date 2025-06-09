import 'package:flutter/material.dart';
import 'package:api_market_cap_coin/domain/entities/digital_asset_model.dart';
import 'package:api_market_cap_coin/domain/repositories/i_digital_asset_repository.dart';
import 'package:api_market_cap_coin/core/library/application_settings.dart';

enum ControllerState { idle, loading, success, error }

class DigitalCurrencyController extends ChangeNotifier {
  final IDigitalAssetRepository _assetRepository;

  DigitalCurrencyController(this._assetRepository);

  List<DigitalAssetModel> _digitalAssets = [];
  List<DigitalAssetModel> get digitalAssets => _digitalAssets;

  ControllerState _state = ControllerState.idle;
  ControllerState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> loadDigitalAssets({String? symbols}) async {
    _state = ControllerState.loading;
    notifyListeners();

    try {
      final symbolsToFetch = symbols == null || symbols.trim().isEmpty 
          ? ApplicationSettings.defaultAssetSymbols 
          : symbols.trim();
      
      print('DigitalCurrencyController: Loading assets with symbols: "$symbolsToFetch"');
      _digitalAssets = await _assetRepository.getDigitalAssets(symbolsToFetch);
      _state = ControllerState.success;
      print('DigitalCurrencyController: Successfully loaded ${_digitalAssets.length} assets.');
    } catch (e) {
      _errorMessage = e.toString();
      _state = ControllerState.error;
      print('DigitalCurrencyController: Error loading assets: $_errorMessage');
    }
    notifyListeners();
  }
}