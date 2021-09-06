import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_item.dart';

class TopExchangeRateModel extends TopExchangeRateItem {
  final double currencyRate;
  final String currencyCode;
  TopExchangeRateModel({required this.currencyRate, required this.currencyCode})
      : super(currencyRate: currencyRate, currencyCode: currencyCode);

  factory TopExchangeRateModel.fromMap(Map<String, dynamic> json) {
    return TopExchangeRateModel(
        currencyRate: json["currency_rate"],
        currencyCode: json["currency_code"]);
  }
}
