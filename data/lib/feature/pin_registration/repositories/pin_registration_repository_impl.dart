import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/pin_registration/data_sources/pin_register_data_source.dart';
import 'package:data/feature/pin_registration/models/pin_info_model.dart';
import 'package:domain/feature/pin_registration/entities/pin_info.dart';
import 'package:domain/feature/pin_registration/repositories/pin_register_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PinRegisterRepository)
class PinRegisterRepositoryImpl extends PinRegisterRepository {
  final PinRegisterDataSource _pinRegisterDataSource;

  PinRegisterRepositoryImpl(this._pinRegisterDataSource);

  @override
  Future<Either<Failure, void>> registerPin(PinInfo pin) async {
    return await _pinRegisterDataSource.savePin(PinInfoModel(pin.pin));
  }
}
