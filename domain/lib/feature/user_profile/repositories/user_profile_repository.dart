import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/user_profile/entities/update_user_info_request.dart';
import 'package:domain/feature/user_profile/entities/user_info.dart';
import 'package:domain/feature/user_profile/entities/verify_user_email_request.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserInfo>> getUserInfo();
  Future<Either<Failure, CommonApiResponse>> updateUserInfo(
      UpdateUserInfoRequest updateUserInfo);
  Future<Either<Failure, CommonApiResponse>> verifyUserEmail(
      VerifyUserEmailRequest verifyUserEmailRequest);
}
