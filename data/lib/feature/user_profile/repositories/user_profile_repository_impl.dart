import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/user_profile/data_sources/user_profile_remote_data_source.dart';
import 'package:data/feature/user_profile/models/update_user_info_model.dart';
import 'package:data/feature/user_profile/models/verify_user_email_model.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/user_profile/entities/update_user_info_request.dart';
import 'package:domain/feature/user_profile/entities/user_info.dart';
import 'package:domain/feature/user_profile/entities/verify_user_email_request.dart';
import 'package:domain/feature/user_profile/repositories/user_profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserProfileRepository)
class UserProfileRepositoryImpl extends UserProfileRepository {
  final UserProfileRemoteDataSource userInfoRemoteDataSource;
  UserProfileRepositoryImpl(this.userInfoRemoteDataSource);

  @override
  Future<Either<Failure, UserInfo>> getUserInfo() async {
    return await userInfoRemoteDataSource.getUserInfo();
  }

  @override
  Future<Either<Failure, CommonApiResponse>> updateUserInfo(
      UpdateUserInfoRequest updateUserInfo) async {
    return await userInfoRemoteDataSource
        .updateUserInfo(UpdateUserInfoModel(updateUserInfo.phoneNumber));
  }

  @override
  Future<Either<Failure, CommonApiResponse>> verifyUserEmail(
      VerifyUserEmailRequest verifyUserEmailRequest) async {
    return await userInfoRemoteDataSource.sendEmailVerification(
        VerifyUserEmailModel(verifyUserEmailRequest.email));
  }
}
