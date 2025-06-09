import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:api_market_cap_coin/ui/view_models/digital_currency_controller.dart';
import 'package:api_market_cap_coin/domain/entities/digital_asset_model.dart';

class DigitalAssetsDashboard extends StatefulWidget {
  const DigitalAssetsDashboard({super.key});

  @override
  State<DigitalAssetsDashboard> createState() => _DigitalAssetsDashboardState();
}

class _DigitalAssetsDashboardState extends State<DigitalAssetsDashboard> {
  final TextEditingController _symbolSearchController = TextEditingController();
  final NumberFormat _dollarFormatter = NumberFormat.currency(locale: 'en_US', symbol: 'USD ');
  final NumberFormat _realFormatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'BRL ');

  @override
  void initState() {
    super.initState();
  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DigitalCurrencyController>(context, listen: false).loadDigitalAssets();
    });
  }

  void _displayAssetDetailsModal(BuildContext context, DigitalAssetModel asset) {
    final dollarValue = asset.priceQuotes['USD']?.currentPrice ?? 0.0;
    final realValue = asset.priceQuotes['BRL']?.currentPrice ?? 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.indigo[100],
                child: Text(
                  asset.assetSymbol.substring(0, asset.assetSymbol.length > 2 ? 2 : asset.assetSymbol.length),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[700],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset.assetName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      asset.assetSymbol,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  label: 'Launch Date',
                  value: DateFormat.yMd().add_jms().format(asset.creationDate.toLocal()),
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  icon: Icons.attach_money,
                  label: 'Value (USD)',
                  value: _dollarFormatter.format(dollarValue),
                  valueColor: Colors.green[600],
                ),
                const SizedBox(height: 16),
                _buildInfoRow(
                  icon: Icons.monetization_on,
                  label: 'Value (BRL)',
                  value: _realFormatter.format(realValue),
                  valueColor: Colors.blue[600],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
              ),
              child: const Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: valueColor ?? Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

 @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DigitalCurrencyController>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Digital Assets',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.indigo[600],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _symbolSearchController,
                decoration: InputDecoration(
                  labelText: 'Buscar Símbolos (ex: BTC, ETH)',
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.indigo[600]),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send, color: Colors.indigo[600]),
                    onPressed: () {
                      controller.loadDigitalAssets(symbols: _symbolSearchController.text);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.indigo[600]!, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                onSubmitted: (value) {
                  controller.loadDigitalAssets(symbols: value);
                },
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.loadDigitalAssets(symbols: _symbolSearchController.text.isEmpty ? null : _symbolSearchController.text),
              color: Colors.indigo[600],
              child: _buildAssetsList(controller),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetsList(DigitalCurrencyController controller) {
    if (controller.state == ControllerState.loading && controller.digitalAssets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo[600]!),
            ),
            const SizedBox(height: 16),
            Text(
              'Carregando ativos digitais...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }
    if (controller.state == ControllerState.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Ops! Algo deu errado',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Falha ao carregar dados: ${controller.errorMessage}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (controller.digitalAssets.isEmpty && controller.state == ControllerState.success) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum ativo digital encontrado',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tente buscar por símbolos diferentes',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }
    if (controller.digitalAssets.isEmpty && controller.state == ControllerState.loading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo[600]!),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: controller.digitalAssets.length,
      itemBuilder: (context, index) {
        final asset = controller.digitalAssets[index];
        final dollarValue = asset.priceQuotes['USD']?.currentPrice ?? 0.0;
        final realValue = asset.priceQuotes['BRL']?.currentPrice ?? 0.0;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: Colors.indigo[100],
              child: Text(
                asset.assetSymbol.substring(0, asset.assetSymbol.length > 2 ? 2 : asset.assetSymbol.length),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo[700],
                  fontSize: 14,
                ),
              ),
            ),
            title: Text(
              '${asset.assetName} (${asset.assetSymbol})',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'USD: ${_dollarFormatter.format(dollarValue)}',
                      style: TextStyle(
                        color: Colors.green[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    'BRL: ${_realFormatter.format(realValue)}',
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
            onTap: () => _displayAssetDetailsModal(context, asset),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _symbolSearchController.dispose();
    super.dispose();
  }
}