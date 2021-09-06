import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/transaction_history/entities/complete_transaction_request.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';
import 'package:domain/core/common_api_response.dart';

@lazySingleton
class CompleteTransaction
    extends UseCase<CommonApiResponse, CompleteTransactionParams> {
  final TransactionHistoryRepository _historyRepository;

  CompleteTransaction(this._historyRepository);

  @override
  Future<Either<Failure, CommonApiResponse>> call(
      CompleteTransactionParams params) {
    return _historyRepository.confirmPendingTransaction(
      CompleteTransactionRequest(
        transRefId: params.transactionRefId,
        pendingTxnBankRefNo: params.pendingTxnBankRefNo,
        referenceDocPath: params.referenceDocPath,
      ),
    );
  }
}

class CompleteTransactionParams extends Equatable {
  final int transactionRefId;
  final int pendingTxnBankRefNo;
  final String referenceDocPath;

  CompleteTransactionParams({
    required this.transactionRefId,
    required this.pendingTxnBankRefNo,
    required this.referenceDocPath,
  });

  @override
  List<Object?> get props => [
        transactionRefId,
        pendingTxnBankRefNo,
        referenceDocPath,
      ];
}
