import 'package:dio/dio.dart';
import 'package:merged_app/crypto/models/coin.dart';
import 'package:merged_app/crypto/models/coin_detail.dart';
import 'package:merged_app/crypto/utils/constants.dart';

class CoinRepository {
  final Dio _dio = Dio();
  final String _apiKey = Constants.apiKey;
  final String _baseUrl = Constants.baseUrl;

  Future<List<Coin>> fetchCoins() async {
    try {
      final response = await _dio.get(
        '$_baseUrl${Constants.coinsEndpoint}',
        queryParameters: {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page': 100,
          'page': 1,
          'sparkline': false,
          'x_cg_demo_api_key': _apiKey,
        },
      );
      
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => Coin.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load coins');
      }
    } catch (e) {
      throw Exception('Failed to load coins: $e');
    }
  }

  Future<CoinDetail> fetchCoinDetail(String id) async {
    try {
      final response = await _dio.get(
        '$_baseUrl${Constants.coinDetailEndpoint.replaceFirst('{id}', id)}',
        queryParameters: {
          'localization': 'false',
          'tickers': 'false',
          'market_data': 'true',
          'community_data': 'false',
          'developer_data': 'false',
          'sparkline': 'false',
          'x_cg_demo_api_key': _apiKey,
        },
      );
      
      if (response.statusCode == 200) {
        return CoinDetail.fromJson(response.data);
      } else {
        throw Exception('Failed to load coin detail');
      }
    } catch (e) {
      throw Exception('Failed to load coin detail: $e');
    }
  }
}