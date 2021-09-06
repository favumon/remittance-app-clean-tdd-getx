import 'package:domain/feature/transaction_history/entities/cancel_transaction_request.dart';

class CancelTransactionRequestModel extends CancelTransactionRequest {
  final int transRefId;
  final String reason;

  CancelTransactionRequestModel(this.transRefId, this.reason)
      : super(transRefId: transRefId, reason: reason);

  Map<String, dynamic> toMap() {
    return {
      'transaction_ref_id': transRefId,
      'cancellation_reason': reason,
    };
  }
}
