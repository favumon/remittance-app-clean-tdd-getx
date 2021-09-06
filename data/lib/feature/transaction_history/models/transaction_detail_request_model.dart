import 'package:domain/feature/transaction_history/entities/transaction_details_request.dart';

class TransactionDetailsRequestModel extends TransactionDetailsRequest {
  final int refrenceId;

  TransactionDetailsRequestModel({required this.refrenceId})
      : super(referenceId: refrenceId);

  Map<String, dynamic> toMap() {
    return {
      'transaction_ref_id': refrenceId,
    };
  }
}
