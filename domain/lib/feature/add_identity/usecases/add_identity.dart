import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/add_identity/entities/identity_data.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddIdentity implements UseCase<CommonApiResponse, AddIdentityParams> {
  final AddIdentityRepository repository;

  AddIdentity(this.repository);

  @override
  Future<Either<Failure, CommonApiResponse>> call(
      AddIdentityParams params) async {
    return await repository.addIdentity(IdentityData(
        params.idType,
        params.idNumber,
        params.expiryDate,
        params.idImage1Path,
        params.idImage2Path,
        params.idSignaturePath,
        params.nationality,
        params.dateOfBirth));
  }
}

class AddIdentityParams extends Equatable {
  final int idType;
  final String idNumber;
  final String expiryDate;
  final String idImage1Path;
  final String idImage2Path;
  final String idSignaturePath;
  final int nationality;
  final String dateOfBirth;
  AddIdentityParams(
      {required this.idType,
      required this.idNumber,
      required this.expiryDate,
      required this.idImage1Path,
      required this.idImage2Path,
      required this.idSignaturePath,
      required this.nationality,
      required this.dateOfBirth});
  @override
  List<Object> get props => [
        this.idType,
        this.idNumber,
        this.expiryDate,
        this.idImage1Path,
        this.idImage2Path,
        this.idSignaturePath,
        this.nationality,
        this.dateOfBirth
      ];
}
