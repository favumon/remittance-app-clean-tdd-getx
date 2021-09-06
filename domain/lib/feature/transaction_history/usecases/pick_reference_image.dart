import 'package:dartz/dartz.dart';

import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/transaction_history/entities/reference_image.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';

@lazySingleton
class PickReferenceImage implements UseCase<ReferenceImage, NoParams> {
  final TransactionHistoryRepository repository;

  PickReferenceImage(this.repository);

  @override
  Future<Either<Failure, ReferenceImage>> call(NoParams params) async {
    return await repository.getReferenceImage();
  }
}
