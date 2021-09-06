import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:domain/feature/change_password/entities/change_password_request.dart';
import 'package:domain/feature/change_password/repositories/change_password_repository.dart';
import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/change_password/entities/change_password_response.dart';

@lazySingleton
class ChangeCurrentPassword
    extends UseCase<ChangePasswordResponse, ChangeCurrentPasswordParams> {
  final ChangePasswordRepository _changePasswordRepository;

  ChangeCurrentPassword(this._changePasswordRepository);

  @override
  Future<Either<Failure, ChangePasswordResponse>> call(
      ChangeCurrentPasswordParams params) {
    return _changePasswordRepository
        .changeCurrentPassword(ChangePasswordRequest(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    ));
  }
}

class ChangeCurrentPasswordParams extends Equatable {
  final String currentPassword;
  final String newPassword;

  ChangeCurrentPasswordParams({
    required this.currentPassword,
    required this.newPassword,
  });
  @override
  List<Object?> get props => [currentPassword, newPassword];
}
