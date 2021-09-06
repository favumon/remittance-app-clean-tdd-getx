import 'package:domain/feature/currency_converter/entity/currency_rate_trend_request.dart';
import 'package:equatable/equatable.dart';

class CurrencyRateTrendRequestModel extends CurrencyRateTrendRequest {
  final String lcCode;
  final String fcCode;

  CurrencyRateTrendRequestModel({required this.lcCode, required this.fcCode})
      : super(fcCode: fcCode, lcCode: lcCode);

  Map<String, dynamic> toMap() {
    return {
      'fc_code': fcCode,
      'lc_code': lcCode,
    };
  }
}
