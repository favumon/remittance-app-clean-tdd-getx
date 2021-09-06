import 'package:dartz/dartz.dart';

import 'package:core/error/failures.dart';
import 'package:domain/feature/settings/entities/biometric_auth_login_enabled.dart';
import 'package:domain/feature/settings/entities/change_biometric_auth_login_request.dart';

abstract class SettingsRepository {
  Future<Either<Failure, BiometricAuthLoginEnabled>>
      getBiometrciAuthLoginEnabledStatus();
  Future<Either<Failure, Null>> changeBiometricAuthLogin(
      ChangeBiometricAuthLoginRequest changeBiometricAuthLoginRequest);
}
