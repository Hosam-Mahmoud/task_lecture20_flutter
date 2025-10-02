import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merged_app/crypto/bloc/coin_bloc.dart';
import 'package:merged_app/crypto/bloc/coin_event.dart';
import 'package:merged_app/crypto/bloc/coin_state.dart';
import 'package:merged_app/crypto/bloc/coin_detail_bloc.dart';
import 'package:merged_app/crypto/bloc/coin_detail_event.dart';
import 'package:merged_app/crypto/models/coin.dart';
import 'package:merged_app/crypto/repository/coin_repository.dart';
import 'package:merged_app/crypto/screens/coin_detail_screen.dart';
import 'package:merged_app/crypto/screens/error_screen.dart';
import 'package:merged_app/crypto/widgets/coin_card.dart';
import 'package:merged_app/crypto/widgets/loading_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoinBloc(coinRepository: CoinRepository())..add(FetchCoins()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cryptocurrency Prices'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<CoinBloc>().add(FetchCoins());
              },
            ),
          ],
        ),
        body: BlocBuilder<CoinBloc, CoinState>(
          builder: (context, state) {
            if (state is CoinLoading) {
              return const LoadingWidget();
            } else if (state is CoinLoaded) {
              return CoinList(coins: state.coins);
            } else if (state is CoinError) {
              return ErrorScreen(error: state.error);
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}

class CoinList extends StatelessWidget {
  final List<Coin> coins;

  const CoinList({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CoinBloc>().add(FetchCoins());
      },
      child: ListView.builder(
        itemCount: coins.length,
        itemBuilder: (context, index) {
          final coin = coins[index];
          return CoinCard(
            coin: coin,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => CoinDetailBloc(
                      coinRepository: CoinRepository(),
                    )..add(FetchCoinDetail(id: coin.id)), 
                    child: const CoinDetailScreen(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}