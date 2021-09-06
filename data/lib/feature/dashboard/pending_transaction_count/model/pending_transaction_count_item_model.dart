import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_item.dart';

class PendingTransactionCountModel extends PendingTransactionCountItem {
  final int pendingTransactionCount;
  PendingTransactionCountModel({required this.pendingTransactionCount})
      : super(pendingTransactionCount: pendingTransactionCount);

  factory PendingTransactionCountModel.fromMap(Map<String, dynamic> json) {
    return PendingTransactionCountModel(
        pendingTransactionCount: json['pending_transaction_count']);
  }
}
