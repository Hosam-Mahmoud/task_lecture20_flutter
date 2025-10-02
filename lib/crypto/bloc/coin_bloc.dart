import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merged_app/crypto/bloc/coin_event.dart';
import 'package:merged_app/crypto/bloc/coin_state.dart';
import 'package:merged_app/crypto/repository/coin_repository.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  final CoinRepository coinRepository;

  CoinBloc({required this.coinRepository}) : super(CoinInitial()) {
    on<FetchCoins>((event, emit) async {
      emit(CoinLoading());
      try {
        final coins = await coinRepository.fetchCoins();
        emit(CoinLoaded(coins: coins));
      } catch (e) {
        emit(CoinError(error: e.toString()));
      }
    });
  }
}