import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/transaction_history/entities/cancel_transaction_request.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';
import 'package:domain/core/common_api_response.dart';

@lazySingleton
class CancelTransaction
    extends UseCase<CommonApiResponse, CancelTransactionParams> {
  final TransactionHistoryRepository _historyRepository;

  CancelTransaction(this._historyRepository);

  @override
  Future<Either<Failure, CommonApiResponse>> call(
      CancelTransactionParams params) {
    return _historyRepository.cancelPendingTransaction(CancelTransactionRequest(
      transRefId: params.transactionRefId,
      reason: params.reasonForCancelleation,
    ));
  }
}

class CancelTransactionParams extends Equatable {
  final int transactionRefId;
  final String reasonForCancelleation;

  CancelTransactionParams(
      {required this.transactionRefId, required this.reasonForCancelleation});

  @override
  List<Object?> get props => [
        transactionRefId,
        reasonForCancelleation,
      ];
}
