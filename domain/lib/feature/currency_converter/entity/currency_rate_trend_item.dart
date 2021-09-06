import 'package:equatable/equatable.dart';

class CurrencyRateTrendItem extends Equatable {
  final double currencyRate;
  final String dateTime;

  CurrencyRateTrendItem({required this.currencyRate, required this.dateTime});
  @override
  List<Object?> get props => [currencyRate, dateTime];
}
