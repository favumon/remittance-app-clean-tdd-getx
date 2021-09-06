import 'package:domain/feature/currency_converter/entity/currency_rate_trend_item.dart';

class CurrencyRateTrendItemModel extends CurrencyRateTrendItem {
  final double currencyRate;
  final String dateTime;

  CurrencyRateTrendItemModel(
      {required this.currencyRate, required this.dateTime})
      : super(
          currencyRate: currencyRate,
          dateTime: dateTime,
        );

  factory CurrencyRateTrendItemModel.fromMap(Map<String, dynamic> json) {
    return CurrencyRateTrendItemModel(
      dateTime: json['date'],
      currencyRate: json['rate'],
    );
  }
}
