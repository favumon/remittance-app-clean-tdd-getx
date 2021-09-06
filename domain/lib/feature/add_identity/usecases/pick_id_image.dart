import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/id_image.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PickIdImage implements UseCase<IdImage, NoParams> {
  final AddIdentityRepository repository;

  PickIdImage(this.repository);

  @override
  Future<Either<Failure, IdImage>> call(NoParams params) async {
    return await repository.getIdImage();
  }
}
