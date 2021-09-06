import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/add_identity/entities/id_image.dart';
import 'package:domain/feature/add_identity/entities/id_type.dart';
import 'package:domain/feature/add_identity/entities/identity_data.dart';
import 'package:domain/feature/add_identity/entities/nationality.dart';
import 'package:domain/feature/add_identity/entities/signature_image.dart';

abstract class AddIdentityRepository {
  Future<Either<Failure, List<IdType>>> getIdTypes();
  Future<Either<Failure, List<Nationality>>> getNationalities();
  Future<Either<Failure, IdImage>> getIdImage();
  Future<Either<Failure, SignatureImage>> getSignatureImage();
  Future<Either<Failure, CommonApiResponse>> addIdentity(
      IdentityData identityData);
}
