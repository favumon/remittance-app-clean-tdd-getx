import 'package:equatable/equatable.dart';

class TopExchangeRateItem extends Equatable {
  final double currencyRate;
  final String currencyCode;
  TopExchangeRateItem({required this.currencyRate, required this.currencyCode});

  @override
  List<Object?> get props => [currencyRate, currencyCode];
}
