import 'package:equatable/equatable.dart';
import 'package:merged_app/crypto/models/coin.dart';

abstract class CoinState extends Equatable {
  const CoinState();

  @override
  List<Object> get props => [];
}

class CoinInitial extends CoinState {}

class CoinLoading extends CoinState {}

class CoinLoaded extends CoinState {
  final List<Coin> coins;

  const CoinLoaded({required this.coins});

  @override
  List<Object> get props => [coins];
}

class CoinError extends CoinState {
  final String error;

  const CoinError({required this.error});

  @override
  List<Object> get props => [error];
}