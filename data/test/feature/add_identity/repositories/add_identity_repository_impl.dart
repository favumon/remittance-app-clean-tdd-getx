import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/add_identity/data_sources/add_identity_remote_data_source.dart';
import 'package:data/feature/add_identity/models/identity_data_model.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/add_identity/entities/id_image.dart';
import 'package:domain/feature/add_identity/entities/id_type.dart';
import 'package:domain/feature/add_identity/entities/identity_data.dart';
import 'package:domain/feature/add_identity/entities/nationality.dart';
import 'package:domain/feature/add_identity/entities/signature_image.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AddIdentityRepository)
class AddIdentityRepositoryImpl extends AddIdentityRepository {
  final AddIdentityDataSource _addIdentityDataSource;

  AddIdentityRepositoryImpl(this._addIdentityDataSource);

  @override
  Future<Either<Failure, List<IdType>>> getIdTypes() async {
    return await _addIdentityDataSource.getIdTypes();
  }

  @override
  Future<Either<Failure, List<Nationality>>> getNationalities() async {
    return await _addIdentityDataSource.getNationalities();
  }

  @override
  Future<Either<Failure, IdImage>> getIdImage() async {
    return await _addIdentityDataSource.getIdImage();
  }

  @override
  Future<Either<Failure, SignatureImage>> getSignatureImage() async {
    return await _addIdentityDataSource.getSignatureImage();
  }

  @override
  Future<Either<Failure, CommonApiResponse>> addIdentity(
      IdentityData identityData) async {
    return await _addIdentityDataSource.addIdentity(
        request: IdentityDataModel(
            identityData.idType,
            identityData.idNumber,
            identityData.expiryDate,
            identityData.idImage1Path,
            identityData.idImage2Path,
            identityData.idSignaturePath,
            identityData.nationality,
            identityData.dateOfBirth));
  }
}
