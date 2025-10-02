import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:merged_app/news/models/article_model.dart';
import 'package:merged_app/news/utils/constants.dart';

class ApiService {
  Future<List<ArticleModel>> fetchTopHeadlines(String category) async {
    final url = '${Constants.baseUrl}/top-headlines?country=us&category=$category&apiKey=${Constants.apiKey}';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List articles = body['articles'];
        return articles.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  Future<List<ArticleModel>> fetchEverything(String query) async {
    final url = '${Constants.baseUrl}/everything?q=$query&apiKey=${Constants.apiKey}';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final List articles = body['articles'];
        return articles.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}