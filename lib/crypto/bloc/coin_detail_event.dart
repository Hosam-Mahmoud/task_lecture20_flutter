import 'package:equatable/equatable.dart';

abstract class CoinDetailEvent extends Equatable {
  const CoinDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchCoinDetail extends CoinDetailEvent {
  final String id;

  const FetchCoinDetail({required this.id});

  @override
  List<Object> get props => [id];
}