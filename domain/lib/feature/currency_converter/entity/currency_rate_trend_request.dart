import 'package:equatable/equatable.dart';

class CurrencyRateTrendRequest extends Equatable {
  final String lcCode;
  final String fcCode;

  CurrencyRateTrendRequest({required this.lcCode,required this.fcCode});

  @override
  List<Object?> get props => [lcCode, fcCode];
}
