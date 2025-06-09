class DigitalAssetModel {
  final int assetId;
  final String assetName;
  final String assetSymbol;
  final String assetSlug;
  final DateTime creationDate;
  final Map<String, PriceQuoteModel> priceQuotes;

  DigitalAssetModel({
    required this.assetId,
    required this.assetName,
    required this.assetSymbol,
    required this.assetSlug,
    required this.creationDate,
    required this.priceQuotes,
  });

  factory DigitalAssetModel.fromJson(Map<String, dynamic> json) {
    return DigitalAssetModel(
      assetId: json['id'] ?? 0,
      assetName: json['name'] ?? '',
      assetSymbol: json['symbol'] ?? '',
      assetSlug: json['slug'] ?? '',
      creationDate: json['date_added'] != null
          ? DateTime.parse(json['date_added'])
          : DateTime.now(),
      priceQuotes: (json['quote'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, PriceQuoteModel.fromJson(value)),
          ) ??
          {},
    );
  }

  Map<String, dynamic> toJson() => {
    'id': assetId,
    'name': assetName,
    'symbol': assetSymbol,
    'slug': assetSlug,
    'date_added': creationDate.toIso8601String(),
    'quote': priceQuotes.map((key, value) => MapEntry(key, value.toJson())),
  };
}

class PriceQuoteModel {
  final double currentPrice;
  final double dailyVolume;
  final double hourlyChange;
  final double dailyChange;
  final double weeklyChange;
  final double totalMarketValue;
  final DateTime lastUpdateTime;

  PriceQuoteModel({
    required this.currentPrice,
    required this.dailyVolume,
    required this.hourlyChange,
    required this.dailyChange,
    required this.weeklyChange,
    required this.totalMarketValue,
    required this.lastUpdateTime,
  });

  factory PriceQuoteModel.fromJson(Map<String, dynamic> json) {
    return PriceQuoteModel(
      currentPrice: (json['price'] ?? 0.0).toDouble(),
      dailyVolume: (json['volume_24h'] ?? 0.0).toDouble(),
      hourlyChange: (json['percent_change_1h'] ?? 0.0).toDouble(),
      dailyChange: (json['percent_change_24h'] ?? 0.0).toDouble(),
      weeklyChange: (json['percent_change_7d'] ?? 0.0).toDouble(),
      totalMarketValue: (json['market_cap'] ?? 0.0).toDouble(),
      lastUpdateTime: json['last_updated'] != null
          ? DateTime.parse(json['last_updated'])
          : DateTime.now(),
    );
  }
   Map<String, dynamic> toJson() => {
    'price': currentPrice,
    'volume_24h': dailyVolume,
    'percent_change_1h': hourlyChange,
    'percent_change_24h': dailyChange,
    'percent_change_7d': weeklyChange,
    'market_cap': totalMarketValue,
    'last_updated': lastUpdateTime.toIso8601String(),
  };
}