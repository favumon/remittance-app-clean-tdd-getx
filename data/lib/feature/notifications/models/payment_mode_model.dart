import 'package:domain/feature/notifications/entity/payment_mode.dart';

class PaymentModeModel extends PaymentMode {
  final String title;
  final String code;

  PaymentModeModel({
    required this.title,
    required this.code,
  }) : super(title: title, code: code);

  factory PaymentModeModel.fromMap(Map<String, dynamic> json) {
    return PaymentModeModel(
      title: json['payment_mode_title'],
      code: json['payment_mode_code'],
    );
  }
}
