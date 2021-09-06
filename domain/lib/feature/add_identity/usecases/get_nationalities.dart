import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/nationality.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetNationalities implements UseCase<List<Nationality>, NoParams> {
  final AddIdentityRepository repository;

  GetNationalities(this.repository);

  @override
  Future<Either<Failure, List<Nationality>>> call(NoParams params) async {
    return await repository.getNationalities();
  }
}
