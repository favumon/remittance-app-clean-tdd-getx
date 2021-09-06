import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:data/feature/change_password/datasources/change_password_datasource.dart';
import 'package:data/feature/change_password/models/change_password_request_model.dart';
import 'package:domain/feature/change_password/entities/change_password_response.dart';
import 'package:domain/feature/change_password/entities/change_password_request.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/change_password/repositories/change_password_repository.dart';

@LazySingleton(as: ChangePasswordRepository)
class ChangePasswordRepositoyimpl implements ChangePasswordRepository {
  final ChangePasswordDatasource _changePasswordDatasource;

  ChangePasswordRepositoyimpl(this._changePasswordDatasource);

  @override
  Future<Either<Failure, ChangePasswordResponse>> changeCurrentPassword(
      ChangePasswordRequest request) {
    return _changePasswordDatasource.changePassword(
      ChangePasswordRequestModel(
          curPwd: request.currentPassword, newPwd: request.newPassword),
    );
  }
}
