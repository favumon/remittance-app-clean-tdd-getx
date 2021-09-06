import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/transaction_history/entities/transaction_payment_mode_filter.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';

@lazySingleton
class GetTransactionPaymentModeFilters
    extends UseCase<List<TransactionPaymentModeFilter>, NoParams> {
  final TransactionHistoryRepository _historyRepository;

  GetTransactionPaymentModeFilters(this._historyRepository);

  @override
  Future<Either<Failure, List<TransactionPaymentModeFilter>>> call(
      NoParams params) {
    return _historyRepository.getTransactionFilters();
  }
}
