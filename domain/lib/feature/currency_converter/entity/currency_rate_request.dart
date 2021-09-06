import 'package:equatable/equatable.dart';

class CurrencyRateRequest extends Equatable {
  final String lcCode;
  final String fcCode;

  CurrencyRateRequest({required this.lcCode, required this.fcCode});

  @override
  List<Object?> get props => [lcCode, fcCode];
}
