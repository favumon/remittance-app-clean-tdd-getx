import 'package:equatable/equatable.dart';

class CurrencyItem extends Equatable {
  final String currencyCode;
  final String currencyName;
  final String flagCode;
  final String countryName;
  final int currencyInDecimals;

  CurrencyItem(
      {required this.currencyCode,
      required this.currencyName,
      required this.countryName,
      required this.flagCode,
      required this.currencyInDecimals});

  @override
  List<Object?> get props =>
      [currencyCode, currencyName, flagCode, countryName, currencyInDecimals];
}
