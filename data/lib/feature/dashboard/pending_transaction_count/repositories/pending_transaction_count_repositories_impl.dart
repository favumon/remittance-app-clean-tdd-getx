import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:data/feature/dashboard/pending_transaction_count/data_sources/pending_transaction_count_data_source.dart';
import 'package:data/feature/dashboard/pending_transaction_count/model/pending_transaction_count_request_model.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_request.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_item.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/repositories/pending_transaction_count_repository.dart';

@LazySingleton(as: PendingTransactionCountRepository)
class PendingTransactionCountRepositoriesImpl
    extends PendingTransactionCountRepository {
  final PendingTransactionCountDataSource _pendingTransactionCountDataSource;

  PendingTransactionCountRepositoriesImpl(
      this._pendingTransactionCountDataSource);

  @override
  Future<Either<Failure, PendingTransactionCountItem>>
      getPendingTransactionCount(
          PendingTransactionCountRequest pendingTransactionCountRequest) {
    return _pendingTransactionCountDataSource
        .getPendingTransactionCount(PendingTransactionCountRequestModel());
  }
}
