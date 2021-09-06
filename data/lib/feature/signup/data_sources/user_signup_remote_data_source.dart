import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/signup/models/signup_info_model.dart';
import 'package:data/feature/signup/models/signup_response_model.dart';
import 'package:data/feature/signup/models/terms_and_conditions_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserSignupRemoteDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  UserSignupRemoteDataSource(this.remoteApi, this.apiEndpoints);

  Future<Either<Failure, SignupResponseModel>> submitSignupInfo(
      SignupInfoModel signupInfo) async {
    var response =
        await remoteApi.apiPost(apiEndpoints.signup, data: signupInfo.toMap());

    return response.fold(
        (l) => Left(l), (r) => Right(SignupResponseModel.fromMap(r)));
  }

  Future<Either<Failure, TermsAndConditionsModel>>
      getTermsAndConditionsText() async {
    var response = await remoteApi.apiGet(apiEndpoints.termsAndConditions);

    return response.fold(
        (l) => Left(l), (r) => Right(TermsAndConditionsModel.fromJson(r)));
  }
}
