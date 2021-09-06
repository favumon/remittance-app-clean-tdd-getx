import 'package:equatable/equatable.dart';

class CompleteTransactionRequest extends Equatable {
  final int transRefId;
  final int pendingTxnBankRefNo;
  final String referenceDocPath;

  CompleteTransactionRequest({
    required this.transRefId,
    required this.pendingTxnBankRefNo,
    required this.referenceDocPath,
  });

  @override
  List<Object?> get props => [
        transRefId,
        pendingTxnBankRefNo,
        referenceDocPath,
      ];
}
