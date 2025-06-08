import 'dart:convert';
import '../../domain/entities/crypto_entity.dart';

class CryptoModel extends CryptoEntity {
  CryptoModel({
    required String nome,
    required String simbolo,
    required double precoUsd,
    required double precoBrl,
    required DateTime dataAdicionada,
  }) : super(
          nome: nome,
          simbolo: simbolo,
          precoUsd: precoUsd,
          precoBrl: precoBrl,
          dataAdicionada: dataAdicionada,
        );

  factory CryptoModel.deJson(Map<String, dynamic> json) {
    final cotacao = json['quote']['USD'];
    final precoUsd = cotacao['price'];
    final precoBrl = precoUsd * 5.0;
    
    return CryptoModel(
      nome: json['name'],
      simbolo: json['symbol'],
      precoUsd: precoUsd,
      precoBrl: precoBrl,
      dataAdicionada: DateTime.parse(json['date_added']),
    );
  }

  String paraJson() => json.encode(paraMapa());

  Map<String, dynamic> paraMapa() => {
        'nome': nome,
        'simbolo': simbolo,
        'precoUsd': precoUsd,
        'precoBrl': precoBrl,
        'dataAdicionada': dataAdicionada.toIso8601String(),
      };
}