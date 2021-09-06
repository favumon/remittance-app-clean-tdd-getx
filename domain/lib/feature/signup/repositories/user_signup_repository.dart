import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/signup/entities/signup_info.dart';
import 'package:domain/feature/signup/entities/signup_response.dart';
import 'package:domain/feature/signup/entities/terms_and_conditions.dart';

abstract class UserSignupRepository {
  Future<Either<Failure, SignupResponse>> submitSignupInfo(
      {required SignupInfo signupInfo, required String otp});
  Future<Either<Failure, TermsAndConditions>> getTermsAndConditionsText();
}
