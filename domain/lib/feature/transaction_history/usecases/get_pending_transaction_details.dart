import 'package:dartz/dartz.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item_details_.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_details_request.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:core/usecases/usecase.dart';

@lazySingleton
class GetPendingTransactionDetails extends UseCase<
    PendingTransactionItemDetails, GetPendingTransactionDetailsParams> {
  final TransactionHistoryRepository _repository;

  GetPendingTransactionDetails(this._repository);

  @override
  Future<Either<Failure, PendingTransactionItemDetails>> call(
      GetPendingTransactionDetailsParams params) {
    return _repository.getPendingTransactionItemDetails(
        PendingTransactionDetailsRequest(referenceId: params.transactionRef));
  }
}

class GetPendingTransactionDetailsParams extends Equatable {
  final int transactionRef;

  GetPendingTransactionDetailsParams(this.transactionRef);

  @override
  List<Object?> get props => [transactionRef];
}
