import 'package:flutter/material.dart';
import 'package:merged_app/crypto/models/coin.dart';
import 'package:intl/intl.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;
  final VoidCallback onTap;

  const CoinCard({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final priceChangeColor = coin.priceChangePercentage24h >= 0 
        ? Colors.green 
        : Colors.red;
    
    final formatter = NumberFormat.currency(name: '\$');
    
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Image.network(
                coin.image,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coin.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      coin.symbol.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatter.format(coin.currentPrice),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: priceChangeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}