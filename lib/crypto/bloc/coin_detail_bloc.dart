import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merged_app/crypto/bloc/coin_detail_event.dart';
import 'package:merged_app/crypto/bloc/coin_detail_state.dart';
import 'package:merged_app/crypto/repository/coin_repository.dart';

class CoinDetailBloc extends Bloc<CoinDetailEvent, CoinDetailState> {
  final CoinRepository coinRepository;

  CoinDetailBloc({required this.coinRepository}) : super(CoinDetailInitial()) {
    on<FetchCoinDetail>((event, emit) async {
      emit(CoinDetailLoading());
      try {
        final coinDetail = await coinRepository.fetchCoinDetail(event.id);
        emit(CoinDetailLoaded(coinDetail: coinDetail));
      } catch (e) {
        emit(CoinDetailError(error: e.toString()));
      }
    });
  }
}