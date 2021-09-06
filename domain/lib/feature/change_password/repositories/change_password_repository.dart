import 'package:dartz/dartz.dart';

import 'package:core/error/failures.dart';
import 'package:domain/feature/change_password/entities/change_password_request.dart';
import 'package:domain/feature/change_password/entities/change_password_response.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, ChangePasswordResponse>> changeCurrentPassword(
      ChangePasswordRequest changePasswordRequest);
}
