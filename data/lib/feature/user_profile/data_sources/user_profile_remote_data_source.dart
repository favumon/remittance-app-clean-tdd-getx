import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/models/common_api_response_model.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/user_profile/models/update_user_info_model.dart';
import 'package:data/feature/user_profile/models/user_info_model.dart';
import 'package:data/feature/user_profile/models/verify_user_email_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserProfileRemoteDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  UserProfileRemoteDataSource(this.remoteApi, this.apiEndpoints);

  Future<Either<Failure, UserInfoModel>> getUserInfo() async {
    var response = await remoteApi.apiGet(apiEndpoints.userProfile);

    return response.fold(
        (l) => Left(l), (r) => Right(UserInfoModel.fromMap(r)));
  }

  Future<Either<Failure, CommonApiResponseModel>> updateUserInfo(
      UpdateUserInfoModel userInfoModel) async {
    var response = await remoteApi.apiPost(apiEndpoints.updateProfile,
        data: userInfoModel.toMap());

    return response.fold((l) {
      if (l is ClientFailure) {
        return Left(UserProfileUpdateFailure(message: l.message));
      }
      return Left(l);
    }, (r) => Right(CommonApiResponseModel.fromMap(r)));
  }

  Future<Either<Failure, CommonApiResponseModel>> sendEmailVerification(
      VerifyUserEmailModel verifyUserEmailModel) async {
    var response = await remoteApi.apiPost(apiEndpoints.sentEmailVerification,
        data: verifyUserEmailModel.toMap());

    return response.fold(
        (l) => Left(l), (r) => Right(CommonApiResponseModel.fromMap(r)));
  }
}
