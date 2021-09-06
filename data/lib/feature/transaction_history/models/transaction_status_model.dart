import 'package:domain/feature/transaction_history/entities/transaction_status.dart';

class TransactionStatusModel extends TransactionStatus {
  final String title;
  final int code;

  TransactionStatusModel({required this.title, required this.code})
      : super(title: title, code: code);

  factory TransactionStatusModel.fromMap(Map<String, dynamic> json) {
    return TransactionStatusModel(
      title: json['transaction_status_title'],
      code: json['transaction_status_code'],
    );
  }
}
