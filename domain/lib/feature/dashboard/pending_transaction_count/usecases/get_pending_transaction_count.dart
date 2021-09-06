import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_request.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_item.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/repositories/pending_transaction_count_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPendingTransactionCount extends UseCase<PendingTransactionCountItem,
    GetPendingTransactionCountParams> {
  final PendingTransactionCountRepository _pendingTransactionCountRepository;

  GetPendingTransactionCount(this._pendingTransactionCountRepository);

  @override
  Future<Either<Failure, PendingTransactionCountItem>> call(
      GetPendingTransactionCountParams params) async {
    return await _pendingTransactionCountRepository
        .getPendingTransactionCount(PendingTransactionCountRequest());
  }
}

class GetPendingTransactionCountParams extends Equatable {
  GetPendingTransactionCountParams();

  @override
  List<Object?> get props => [];
}
