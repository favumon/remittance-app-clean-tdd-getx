import 'package:domain/feature/transaction_history/entities/pending_transaction_details_request.dart';

class PendingTransactionDetailsRequestModel
    extends PendingTransactionDetailsRequest {
  final int referenceId;

  PendingTransactionDetailsRequestModel(this.referenceId)
      : super(referenceId: referenceId);

  Map<String, dynamic> toMap() {
    return {
      'transaction_ref_id': referenceId,
    };
  }
}
