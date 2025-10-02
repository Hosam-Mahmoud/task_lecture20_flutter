class Coin {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double marketCap;
  final int marketCapRank;
  final double fullyDilutedValuation;
  final double totalVolume;
  final double high24h;
  final double low24h;
  final double priceChange24h;
  final double priceChangePercentage24h;
  final double marketCapChange24h;
  final double marketCapChangePercentage24h;
  final double circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double ath;
  final double athChangePercentage;
  final String athDate;
  final double atl;
  final double atlChangePercentage;
  final String atlDate;
  final String? lastUpdated; // تغيير النوع من double? إلى String?

  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.marketCapChange24h,
    required this.marketCapChangePercentage24h,
    required this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    this.lastUpdated, // تم تغيير النوع هنا
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price']?.toDouble() ?? 0.0,
      marketCap: json['market_cap']?.toDouble() ?? 0.0,
      marketCapRank: json['market_cap_rank'] ?? 0,
      fullyDilutedValuation: json['fully_diluted_valuation']?.toDouble() ?? 0.0,
      totalVolume: json['total_volume']?.toDouble() ?? 0.0,
      high24h: json['high_24h']?.toDouble() ?? 0.0,
      low24h: json['low_24h']?.toDouble() ?? 0.0,
      priceChange24h: json['price_change_24h']?.toDouble() ?? 0.0,
      priceChangePercentage24h: json['price_change_percentage_24h']?.toDouble() ?? 0.0,
      marketCapChange24h: json['market_cap_change_24h']?.toDouble() ?? 0.0,
      marketCapChangePercentage24h: json['market_cap_change_percentage_24h']?.toDouble() ?? 0.0,
      circulatingSupply: json['circulating_supply']?.toDouble() ?? 0.0,
      totalSupply: json['total_supply']?.toDouble(),
      maxSupply: json['max_supply']?.toDouble(),
      ath: json['ath']?.toDouble() ?? 0.0,
      athChangePercentage: json['ath_change_percentage']?.toDouble() ?? 0.0,
      athDate: json['ath_date'] ?? '',
      atl: json['atl']?.toDouble() ?? 0.0,
      atlChangePercentage: json['atl_change_percentage']?.toDouble() ?? 0.0,
      atlDate: json['atl_date'] ?? '',
      lastUpdated: json['last_updated'], // تم تغيير هذا السطر
    );
  }
}