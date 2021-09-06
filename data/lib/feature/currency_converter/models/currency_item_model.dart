import 'package:domain/feature/currency_converter/entity/currency_item.dart';

class CurrencyItemModel extends CurrencyItem {
  final String currencyCode;
  final String currencyName;
  final String flagCode;
  final String countryName;
  final int currencyInDecimals;

  CurrencyItemModel(
      {required this.currencyCode,
      required this.currencyName,
      required this.countryName,
      required this.flagCode,
      required this.currencyInDecimals})
      : super(
            countryName: countryName,
            currencyCode: currencyCode,
            currencyName: currencyName,
            flagCode: flagCode,
            currencyInDecimals: currencyInDecimals);

  factory CurrencyItemModel.fromMap(Map<String, dynamic> json) {
    return CurrencyItemModel(
        currencyCode: json['currency_code'],
        currencyName: json['currency_name'],
        countryName: json['country_name'],
        flagCode: json['flag_code'],
        currencyInDecimals: json['currency_in_decimals']);
  }
}
