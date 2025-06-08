class CryptoEntity {
  final String nome;
  final String simbolo;
  final double precoUsd;
  final double precoBrl;
  final DateTime dataAdicionada;

  CryptoEntity({
    required this.nome,
    required this.simbolo,
    required this.precoUsd,
    required this.precoBrl,
    required this.dataAdicionada,
  });
}