import 'package:dio/dio.dart';
import 'package:domain/feature/transaction_history/entities/complete_transaction_request.dart';

class CompleteTransactionRequestModel extends CompleteTransactionRequest {
  final int transRefId;
  final int pendingTxnBankRefNo;
  final String docPath;

  CompleteTransactionRequestModel({
    required this.transRefId,
    required this.pendingTxnBankRefNo,
    required this.docPath,
  }) : super(
            transRefId: transRefId,
            pendingTxnBankRefNo: pendingTxnBankRefNo,
            referenceDocPath: docPath);

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'transaction_ref_id': transRefId,
      'transaction_bank_ref_no': pendingTxnBankRefNo,
      'reference_document': await MultipartFile.fromFile(docPath)
    });
  }
}
