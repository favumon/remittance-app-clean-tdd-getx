import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:domain/feature/settings/entities/change_biometric_auth_login_request.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/settings/repositories/settings_repository.dart';
import 'package:core/usecases/usecase.dart';

@lazySingleton
class ChangeBiometricAuthLogin
    extends UseCase<Null, ChangeBiometricAuthLoginParams> {
  final SettingsRepository _repository;

  ChangeBiometricAuthLogin(this._repository);

  @override
  Future<Either<Failure, Null>> call(
      ChangeBiometricAuthLoginParams params) async {
    return _repository.changeBiometricAuthLogin(
      ChangeBiometricAuthLoginRequest(params.value),
    );
  }
}

class ChangeBiometricAuthLoginParams extends Equatable {
  final bool value;
  ChangeBiometricAuthLoginParams(this.value);
  @override
  List<Object?> get props => [value];
}
