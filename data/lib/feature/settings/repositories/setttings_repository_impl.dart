import 'package:dartz/dartz.dart';
import 'package:data/feature/settings/models/change_biometric_auth_login_request_model.dart';
import 'package:injectable/injectable.dart';

import 'package:data/feature/settings/datasources/settings_datasources.dart';
import 'package:data/feature/settings/models/biometric_auth_enabled_model.dart';
import 'package:domain/feature/settings/entities/change_biometric_auth_login_request.dart';
import 'package:domain/feature/settings/entities/biometric_auth_login_enabled.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/settings/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SetttingsRepositoryImpl implements SettingsRepository {
  final SettigsDatasources _datasources;

  SetttingsRepositoryImpl(this._datasources);

  @override
  Future<Either<Failure, BiometricAuthLoginEnabled>>
      getBiometrciAuthLoginEnabledStatus() async {
    var res = _datasources.isBiometricAuthEnabled();

    return !(res ?? false)
        ? Left(BiometricAuthLoginEnabledFailure())
        : Right(BiometricAuthLoginEnabledModel());
  }

  @override
  Future<Either<Failure, Null>> changeBiometricAuthLogin(
      ChangeBiometricAuthLoginRequest request) async {
    return await _datasources.toggleBiometricAuth(
        ChangeBiometricAuthLoginRequestModel(request.value));
  }
}
