import 'package:equatable/equatable.dart';

class PaymentMode extends Equatable {
  final String title;
  final String code;

  PaymentMode({
    required this.title,
    required this.code,
  });

  @override
  List<Object?> get props => [
        title,
        code,
      ];
}
