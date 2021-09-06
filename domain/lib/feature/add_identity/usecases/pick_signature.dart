import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/signature_image.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PickSignature implements UseCase<SignatureImage, NoParams> {
  final AddIdentityRepository repository;

  PickSignature(this.repository);

  @override
  Future<Either<Failure, SignatureImage>> call(NoParams params) async {
    return await repository.getSignatureImage();
  }
}
