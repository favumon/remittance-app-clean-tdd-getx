import 'package:dartz/dartz.dart';
import 'package:domain/core/utils/helper_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';
import 'package:core/usecases/usecase.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_list_request.dart';

@injectable
class GetPendingTransactionHistoryList extends UseCase<
    List<PendingTransactionItem>, GetPendingTransactionHistoryListParams> {
  final TransactionHistoryRepository _transactionHistoryRepository;

  GetPendingTransactionHistoryList(this._transactionHistoryRepository);

  @override
  Future<Either<Failure, List<PendingTransactionItem>>> call(
      GetPendingTransactionHistoryListParams params) {
    return _transactionHistoryRepository.getPendingTransactionsList(
        PendingTransactionListRequest(
            paymentModeFilterList: params.paymentModeList));
  }
}

class GetPendingTransactionHistoryListParams extends Equatable {
  final List<int> paymentModeList;

  GetPendingTransactionHistoryListParams(this.paymentModeList);

  @override
  List<Object?> get props => [paymentModeList];
}
