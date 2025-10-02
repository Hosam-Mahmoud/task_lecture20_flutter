// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merged_app/crypto/bloc/coin_bloc.dart';
import 'package:merged_app/crypto/bloc/coin_event.dart';
import 'package:merged_app/crypto/repository/coin_repository.dart';
import 'package:merged_app/main_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto & News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          // نحتاج فقط لتوفير CoinBloc هنا
          BlocProvider(
            create: (context) => CoinBloc(coinRepository: CoinRepository())..add(FetchCoins()),
          ),
        ],
        child: const MainContainer(),
      ),
    );
  }
}