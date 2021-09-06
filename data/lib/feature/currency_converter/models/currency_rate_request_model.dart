import 'package:domain/feature/currency_converter/entity/currency_rate_request.dart';

class CurrencyRateRequestModel extends CurrencyRateRequest {
  final String lcCode;
  final String fcCode;

  CurrencyRateRequestModel({required this.lcCode, required this.fcCode})
      : super(
          fcCode: fcCode,
          lcCode: lcCode,
        );

  Map<String, dynamic> toMap() {
    return {
      'fc_code': fcCode,
      'lc_code': lcCode,
    };
  }
}
