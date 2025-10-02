import 'package:flutter/material.dart';
import 'package:merged_app/news/models/article_model.dart';
import 'package:merged_app/news/models/category_model.dart';
import 'package:merged_app/news/screens/news_detail_screen.dart';
import 'package:merged_app/news/services/api_service.dart';
import 'package:merged_app/news/widgets/category_card.dart';
import 'package:merged_app/news/widgets/news_card.dart';
import 'package:merged_app/news/widgets/shimmer_loading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  List<CategoryModel> _categories = [];
  List<ArticleModel> _articles = [];
  bool _isLoading = true;
  String _selectedCategory = 'general';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _categories = CategoryModel.getCategories();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final articles = await _apiService.fetchTopHeadlines(_selectedCategory);
      setState(() {
        _articles = articles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load news. Please try again later.';
      });
    }
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NewsSearchDelegate(_apiService),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories section
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CategoryCard(
                    category: category,
                    isSelected: _selectedCategory == category.id,
                    onTap: () => _onCategorySelected(category.id),
                  ),
                );
              },
            ),
          ),
          
          // News section
          Expanded(
            child: _buildNewsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    if (_isLoading) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => const ShimmerLoading(),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchNews,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_articles.isEmpty) {
      return const Center(
        child: Text('No news available'),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchNews,
      child: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          final article = _articles[index];
          return NewsCard(
            article: article,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NewsSearchDelegate extends SearchDelegate<List<ArticleModel>> {
  final ApiService _apiService;

  NewsSearchDelegate(this._apiService);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a search term'),
      );
    }

    return FutureBuilder<List<ArticleModel>>(
      future: _apiService.fetchEverything(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SpinKitFadingCircle(
              color: Colors.green,
              size: 50.0,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No results found'),
          );
        } else {
          final articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return NewsCard(
                article: article,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailScreen(article: article),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Search for news'),
    );
  }
}