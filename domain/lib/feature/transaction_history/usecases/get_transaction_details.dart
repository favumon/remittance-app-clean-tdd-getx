import 'package:dartz/dartz.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_request.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:core/usecases/usecase.dart';

@lazySingleton
class GetTransactionDetails
    extends UseCase<TransactionDetailsItem, GetTransactionDetailsParams> {
  final TransactionHistoryRepository _repository;

  GetTransactionDetails(this._repository);

  @override
  Future<Either<Failure, TransactionDetailsItem>> call(
      GetTransactionDetailsParams params) {
    return _repository.getTransactionItemDetails(
        TransactionDetailsRequest(referenceId: params.transactionRef));
  }
}

class GetTransactionDetailsParams extends Equatable {
  final int transactionRef;

  GetTransactionDetailsParams(this.transactionRef);

  @override
  List<Object?> get props => [transactionRef];
}
