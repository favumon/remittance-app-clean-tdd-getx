import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_request.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_status.dart';
import 'package:domain/feature/biometric_authetication/repositories/biometric_authetication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AutheticateWithBiometrics
    implements
        UseCase<BiometricAuthenticationStatus,
            AutheticateWithBiometricsParams> {
  final BiometricAutheticationRepository repository;

  AutheticateWithBiometrics(this.repository);

  @override
  Future<Either<Failure, BiometricAuthenticationStatus>> call(
      AutheticateWithBiometricsParams params) async {
    return await repository.autheticateWithBiometrics(
        BiometricAuthenticationRequest(params.promptReason));
  }
}

class AutheticateWithBiometricsParams extends Equatable {
  final String promptReason;

  AutheticateWithBiometricsParams(this.promptReason);
  @override
  List<Object> get props => [promptReason];
}
