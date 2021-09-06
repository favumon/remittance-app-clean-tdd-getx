import 'package:dartz/dartz.dart';
import 'package:data/feature/signup/data_sources/user_signup_remote_data_source.dart';
import 'package:data/feature/signup/models/signup_info_model.dart';
import 'package:data/feature/signup/models/signup_response_model.dart';
import 'package:data/feature/signup/models/terms_and_conditions_model.dart';
import 'package:data/feature/signup/repositories/user_signup_repository_impl.dart';
import 'package:domain/feature/signup/entities/signup_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_signup_repository_impl_test.mocks.dart';
 
@GenerateMocks([UserSignupRemoteDataSource])
main() {
  late UserSignupRepositoryImpl userSignupRepositoryImpl;
  late MockUserSignupRemoteDataSource mockUserSignupRemoteDataSource;
  setUp(() {
    mockUserSignupRemoteDataSource = MockUserSignupRemoteDataSource();
    userSignupRepositoryImpl =
        UserSignupRepositoryImpl(mockUserSignupRemoteDataSource);
  });
  test('should get Terms and Conditions from Remote data source', () async {
    final termsAndConditionsModel =
        TermsAndConditionsModel(termsAndConditionsText: 'terms and conditions');

    when(mockUserSignupRemoteDataSource.getTermsAndConditionsText()).thenAnswer(
        (realInvocation) => Future.value(Right(termsAndConditionsModel)));
    final result = await userSignupRepositoryImpl.getTermsAndConditionsText();

    expect(result, Right(termsAndConditionsModel));
  });
  test('should submit signup info to SignupRemoteDataSource and get result',
      () async {
    final signupInfoModel = SignupInfoModel(
        email: 'email',
        firstName: 'firstName',
        lastName: 'lastName',
        middleName: 'middleName',
        otp: 'otp',
        password: 'password',
        phoneNumber: 'phoneNumber',
        username: 'username');
    final signupInfo = SignupInfo(
        email: 'email',
        firstName: 'firstName',
        lastName: 'lastName',
        middleName: 'middleName',
        password: 'password',
        phoneNumber: 'phoneNumber',
        username: 'username');

    when(mockUserSignupRemoteDataSource.submitSignupInfo(signupInfoModel))
        .thenAnswer(
            (realInvocation) => Future.value(Right(SignupResponseModel())));
    final result = await userSignupRepositoryImpl.submitSignupInfo(
        signupInfo: signupInfo, otp: 'otp');

    expect(result, Right(SignupResponseModel()));
  });
}
