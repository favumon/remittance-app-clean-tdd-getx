import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_request.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_item.dart';

abstract class PendingTransactionCountRepository {
  Future<Either<Failure, PendingTransactionCountItem>>
      getPendingTransactionCount(
          PendingTransactionCountRequest pendingTransactionCountRequest);
}
