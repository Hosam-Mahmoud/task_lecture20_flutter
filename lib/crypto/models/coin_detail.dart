class CoinDetail {
  final String id;
  final String symbol;
  final String name;
  final String? description;
  final Map<String, dynamic> links;
  final Map<String, dynamic> image;
  final Map<String, dynamic> marketData;

  CoinDetail({
    required this.id,
    required this.symbol,
    required this.name,
    this.description,
    required this.links,
    required this.image,
    required this.marketData,
  });

  factory CoinDetail.fromJson(Map<String, dynamic> json) {
    return CoinDetail(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      description: json['description']?['en'],
      links: Map<String, dynamic>.from(json['links'] ?? {}),
      image: Map<String, dynamic>.from(json['image'] ?? {}),
      marketData: Map<String, dynamic>.from(json['market_data'] ?? {}),
    );
  }
}