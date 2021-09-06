import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/core/device/local_storage.dart';
import 'package:data/feature/pin_registration/models/pin_info_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PinRegisterDataSource {
  final LocalStorage localStorage;

  PinRegisterDataSource(this.localStorage);

  Future<Either<Failure, void>> savePin(PinInfoModel pinInfo) async {
    localStorage.saveString(loginPin, pinInfo.pin);
    return Future.value(Right(null));
  }
}
