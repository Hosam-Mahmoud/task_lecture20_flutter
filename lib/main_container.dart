// lib/main_container.dart
import 'package:flutter/material.dart';
import 'package:merged_app/crypto/home_screen.dart' as crypto;
import 'package:merged_app/news/home_screen.dart' as news;

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _currentIndex = 0;

// ثم في القائمة:
final List<Widget> _screens = [
  const crypto.HomeScreen(),
  const news.HomeScreen(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_bitcoin),
            label: 'Cryptocurrency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
        ],
      ),
    );
  }
}