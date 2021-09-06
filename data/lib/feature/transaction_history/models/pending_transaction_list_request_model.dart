import 'dart:convert';

import 'package:domain/feature/transaction_history/entities/pending_transaction_list_request.dart';

class PendingTransactionListRequestModel extends PendingTransactionListRequest {
  final List<int> paymentModeFilterListString;

  PendingTransactionListRequestModel(
    this.paymentModeFilterListString,
  ) : super(paymentModeFilterList: []);

  Map<String, dynamic> toMap() {
    return {
      'filter_list': jsonEncode(paymentModeFilterListString),
    };
  }
}
