import 'package:domain/feature/currency_converter/entity/currency_rate.dart';

class CurrencyRateModel extends CurrencyRate {
  final double rate;

  CurrencyRateModel({required this.rate}):super(rate: rate);

  factory CurrencyRateModel.fromMap(Map<String, dynamic> json){
    return CurrencyRateModel(rate: json['normal_rate']);
  }
}
