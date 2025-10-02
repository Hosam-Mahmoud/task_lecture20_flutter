import 'package:equatable/equatable.dart';
import 'package:merged_app/crypto/models/coin_detail.dart';

abstract class CoinDetailState extends Equatable {
  const CoinDetailState();

  @override
  List<Object> get props => [];
}

class CoinDetailInitial extends CoinDetailState {}

class CoinDetailLoading extends CoinDetailState {}

class CoinDetailLoaded extends CoinDetailState {
  final CoinDetail coinDetail;

  const CoinDetailLoaded({required this.coinDetail});

  @override
  List<Object> get props => [coinDetail];
}

class CoinDetailError extends CoinDetailState {
  final String error;

  const CoinDetailError({required this.error});

  @override
  List<Object> get props => [error];
}