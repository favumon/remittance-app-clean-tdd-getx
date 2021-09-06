import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/id_type.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetIdTypes implements UseCase<List<IdType>, NoParams> {
  final AddIdentityRepository repository;

  GetIdTypes(this.repository);

  @override
  Future<Either<Failure, List<IdType>>> call(NoParams params) async {
    return await repository.getIdTypes();
  }
}
