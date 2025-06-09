import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_market_cap_coin/core/service/network_client.dart';
import 'package:api_market_cap_coin/data/datasources/market_data_provider.dart';
import 'package:api_market_cap_coin/data/repositories/digital_asset_repository.dart';
import 'package:api_market_cap_coin/domain/repositories/i_digital_asset_repository.dart';
import 'package:api_market_cap_coin/ui/view_models/digital_currency_controller.dart';
import 'package:api_market_cap_coin/ui/pages/digital_assets_dashboard.dart';


void main() async {
 
  runApp(const DigitalAssetTracker());
}

class DigitalAssetTracker extends StatelessWidget {
  const DigitalAssetTracker({super.key});

  @override
  Widget build(BuildContext context) {
   
    final NetworkClient networkClient = NetworkClient();
    final IMarketDataProvider dataProvider = MarketDataProvider(networkClient);
    final IDigitalAssetRepository assetRepository = DigitalAssetRepository(dataProvider);

    return ChangeNotifierProvider(
      create: (context) => DigitalCurrencyController(assetRepository),
      child: MaterialApp(
        title: 'Digital Asset Portfolio Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepPurple[400],
            foregroundColor: Colors.white,
            elevation: 4,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          dialogTheme: DialogThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)
            )
          )
        ),
        home: const DigitalAssetsDashboard(),
      ),
    );
  }
}
