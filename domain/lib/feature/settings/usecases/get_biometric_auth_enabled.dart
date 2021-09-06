import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/settings/entities/biometric_auth_login_enabled.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/settings/repositories/settings_repository.dart';
import 'package:core/usecases/usecase.dart';

@lazySingleton
class GetBiometricAuthEnabled
    extends UseCase<BiometricAuthLoginEnabled, NoParams> {
  final SettingsRepository _repository;

  GetBiometricAuthEnabled(this._repository);

  @override
  Future<Either<Failure, BiometricAuthLoginEnabled>> call(
      NoParams params) async {
    return _repository.getBiometrciAuthLoginEnabledStatus();
  }
}
