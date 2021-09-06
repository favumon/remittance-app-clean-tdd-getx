import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/identity_list/entities/identity_details.dart';
import 'package:domain/feature/identity_list/repositories/identity_list_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetIdentities implements UseCase<List<IdentityDetails>, NoParams> {
  final IdentityListRepository repository;

  GetIdentities(this.repository);

  @override
  Future<Either<Failure, List<IdentityDetails>>> call(NoParams params) async {
    return await repository.getIdentities();
  }
}
