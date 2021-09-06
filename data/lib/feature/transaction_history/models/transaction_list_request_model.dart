import 'dart:convert';

import 'package:domain/feature/transaction_history/entities/transaction_list_request.dart';

class TransactionListRequestModel extends TransactionListRequest {
  final List<int> paymentModeFilterListString;

  TransactionListRequestModel(
    this.paymentModeFilterListString,
  ) : super(paymentModeFilterList: []);

  Map<String, dynamic> toMap() {
    return {
      'filter_list': jsonEncode(paymentModeFilterListString),
    };
  }
}
