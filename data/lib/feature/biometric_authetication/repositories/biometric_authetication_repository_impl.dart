import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/biometric_authetication/data_sources/biometric_authetication_data_source.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_request_model.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_availability.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_request.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_status.dart';
import 'package:domain/feature/biometric_authetication/repositories/biometric_authetication_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BiometricAutheticationRepository)
class BiometricAutheticationRepositoryImpl
    extends BiometricAutheticationRepository {
  final BiometricAutheticationDataSource _biometricAutheticationDataSource;

  BiometricAutheticationRepositoryImpl(this._biometricAutheticationDataSource);

  @override
  Future<Either<Failure, BiometricAuthenticationAvailability>>
      checkBiometricAvailable() async {
    var available =
        await _biometricAutheticationDataSource.checkBiometricsAvailable();

    return available.isBiometricAvailable
        ? Right(available)
        : Left(BiometricAuthenticationFailure());
  }

  @override
  Future<Either<Failure, BiometricAuthenticationStatus>>
      autheticateWithBiometrics(BiometricAuthenticationRequest request) async {
    var available =
        await _biometricAutheticationDataSource.authenticateWithBiometrics(
            BiometricAuthenticationRequestModel(request.promptMessage));

    return available.isAutheticated
        ? Right(available)
        : Left(BiometricAuthenticationFailure());
  }
}
