import 'package:equatable/equatable.dart';

class CurrencyRate extends Equatable {
  final double rate;

  CurrencyRate({required this.rate});

  @override
  List<Object?> get props => [rate];
}
