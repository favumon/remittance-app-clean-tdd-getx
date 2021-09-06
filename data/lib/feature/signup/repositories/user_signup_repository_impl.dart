import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/signup/data_sources/user_signup_remote_data_source.dart';
import 'package:data/feature/signup/models/signup_info_model.dart';
import 'package:domain/feature/signup/entities/signup_info.dart';
import 'package:domain/feature/signup/entities/signup_response.dart';
import 'package:domain/feature/signup/entities/terms_and_conditions.dart';
import 'package:domain/feature/signup/repositories/user_signup_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserSignupRepository)
class UserSignupRepositoryImpl extends UserSignupRepository {
  final UserSignupRemoteDataSource _userSignupRemoteDataSource;

  UserSignupRepositoryImpl(this._userSignupRemoteDataSource);

  @override
  Future<Either<Failure, SignupResponse>> submitSignupInfo(
      {required SignupInfo signupInfo, required String otp}) async {
    return await _userSignupRemoteDataSource.submitSignupInfo(SignupInfoModel(
      email: signupInfo.email,
      firstName: signupInfo.firstName,
      lastName: signupInfo.lastName,
      middleName: signupInfo.middleName,
      otp: otp,
      password: signupInfo.password,
      phoneNumber: signupInfo.phoneNumber,
      username: signupInfo.username,
    ));
  }

  @override
  Future<Either<Failure, TermsAndConditions>>
      getTermsAndConditionsText() async {
    return await _userSignupRemoteDataSource.getTermsAndConditionsText();
  }
}
