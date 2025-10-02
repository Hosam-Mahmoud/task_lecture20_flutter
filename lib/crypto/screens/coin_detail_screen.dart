import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merged_app/crypto/bloc/coin_detail_bloc.dart';
import 'package:merged_app/crypto/bloc/coin_detail_state.dart';
import 'package:merged_app/crypto/models/coin_detail.dart';
import 'package:merged_app/crypto/screens/error_screen.dart';
import 'package:merged_app/crypto/widgets/loading_widget.dart';
import 'package:intl/intl.dart';

class CoinDetailScreen extends StatelessWidget {
  const CoinDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Details'),
      ),
      body: BlocBuilder<CoinDetailBloc, CoinDetailState>(
        builder: (context, state) {
          if (state is CoinDetailLoading) {
            return const LoadingWidget();
          } else if (state is CoinDetailLoaded) {
            return CoinDetailContent(coinDetail: state.coinDetail);
          } else if (state is CoinDetailError) {
            return ErrorScreen(error: state.error);
          }
          return const LoadingWidget();
        },
      ),
    );
  }
}

class CoinDetailContent extends StatelessWidget {
  final CoinDetail coinDetail;

  const CoinDetailContent({super.key, required this.coinDetail});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(name: '\$');
    final marketData = coinDetail.marketData;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                coinDetail.image['large'] ?? '',
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coinDetail.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      coinDetail.symbol.toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            coinDetail.description ?? 'No description available',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Text(
            'Market Data',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            'Current Price',
            formatter.format(marketData['current_price']?['usd'] ?? 0),
          ),
          _buildDetailRow(
            'Market Cap',
            formatter.format(marketData['market_cap']?['usd'] ?? 0),
          ),
          _buildDetailRow(
            '24h Volume',
            formatter.format(marketData['total_volume']?['usd'] ?? 0),
          ),
          _buildDetailRow(
            '24h High',
            formatter.format(marketData['high_24h']?['usd'] ?? 0),
          ),
          _buildDetailRow(
            '24h Low',
            formatter.format(marketData['low_24h']?['usd'] ?? 0),
          ),
          _buildDetailRow(
            'Price Change 24h',
            '${marketData['price_change_percentage_24h']?.toStringAsFixed(2) ?? 0}%',
          ),
          _buildDetailRow(
            'Market Cap Change 24h',
            '${marketData['market_cap_change_percentage_24h']?.toStringAsFixed(2) ?? 0}%',
          ),
          _buildDetailRow(
            'Circulating Supply',
            '${marketData['circulating_supply']?.toStringAsFixed(0) ?? 0} ${coinDetail.symbol.toUpperCase()}',
          ),
          if (marketData['total_supply'] != null)
            _buildDetailRow(
              'Total Supply',
              '${marketData['total_supply']?.toStringAsFixed(0) ?? 0} ${coinDetail.symbol.toUpperCase()}',
            ),
          if (marketData['max_supply'] != null)
            _buildDetailRow(
              'Max Supply',
              '${marketData['max_supply']?.toStringAsFixed(0) ?? 0} ${coinDetail.symbol.toUpperCase()}',
            ),
          const SizedBox(height: 24),
          Text(
            'Links',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 16),
          if (coinDetail.links['homepage'] != null && coinDetail.links['homepage'].isNotEmpty)
            _buildLinkRow('Homepage', coinDetail.links['homepage'][0]),
          if (coinDetail.links['blockchain_site'] != null && coinDetail.links['blockchain_site'].isNotEmpty)
            _buildLinkRow('Blockchain Explorer', coinDetail.links['blockchain_site'][0]),
          if (coinDetail.links['official_forum_url'] != null && coinDetail.links['official_forum_url'].isNotEmpty)
            _buildLinkRow('Official Forum', coinDetail.links['official_forum_url'][0]),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkRow(String label, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          InkWell(
            onTap: () {
          
            },
            child: Text(
              url,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}