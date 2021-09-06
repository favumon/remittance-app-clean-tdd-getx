import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/transaction_history/entities/transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_list_request.dart';
import 'package:core/error/failures.dart';

@injectable
class GetTransactionHistoryList
    extends UseCase<List<TransactionItem>, GetTransactionHistoryListParams> {
  final TransactionHistoryRepository _transactionHistoryRepository;

  GetTransactionHistoryList(this._transactionHistoryRepository);

  @override
  Future<Either<Failure, List<TransactionItem>>> call(
      GetTransactionHistoryListParams params) {
    var req = TransactionListRequest(
      paymentModeFilterList: params.paymentModeList,
    );

    return _transactionHistoryRepository.getTransactionsList(req);
  }
}

class GetTransactionHistoryListParams extends Equatable {
  final List<int> paymentModeList;

  GetTransactionHistoryListParams(this.paymentModeList);

  @override
  List<Object?> get props => [
        paymentModeList,
      ];
}
