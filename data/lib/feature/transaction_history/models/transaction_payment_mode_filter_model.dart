import 'package:domain/feature/transaction_history/entities/transaction_payment_mode_filter.dart';

class TransactionPaymentModeFilterModel extends TransactionPaymentModeFilter {
  final String title;
  final int code;

  TransactionPaymentModeFilterModel({required this.title, required this.code})
      : super(
          title: title,
          code: code,
        );

  factory TransactionPaymentModeFilterModel.fromMap(Map<String, dynamic> json) {
    return TransactionPaymentModeFilterModel(
      title: json['payment_mode_title'],
      code: json['payment_mode_code'],
    );
  }
}
