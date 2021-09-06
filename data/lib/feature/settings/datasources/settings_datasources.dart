import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:data/feature/settings/models/change_biometric_auth_login_request_model.dart';
import 'package:data/core/device/local_storage.dart';
import 'package:core/error/failures.dart';

@lazySingleton
class SettigsDatasources {
  final LocalStorage _localStorage;

  SettigsDatasources(this._localStorage);

  bool? isBiometricAuthEnabled() {
    var res = _localStorage.getBool(BIOMETRIC_AUTH_ENABLED);
    return res; //TODO check the key is here
  }

  Future<Either<Failure, Null>> toggleBiometricAuth(
      ChangeBiometricAuthLoginRequestModel model) async {
    var res = await _localStorage.saveBool(BIOMETRIC_AUTH_ENABLED, model.value);

    return res ? Right(null) : Left(LocalStorageFailure());
  }
}
