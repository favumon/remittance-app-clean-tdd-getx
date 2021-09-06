import 'package:dartz/dartz.dart';
import 'package:data/core/models/common_api_response_model.dart';
import 'package:data/feature/otp_authentication/data_sources/otp_authentication_data_source.dart';
import 'package:data/feature/otp_authentication/models/otp_generation_request_model.dart';
import 'package:data/feature/otp_authentication/models/otp_verification_request_model.dart';
import 'package:data/feature/otp_authentication/repositories/otp_authentication_repository_impl.dart';
import 'package:domain/feature/otp_verification/entities/otp_generation_request.dart';
import 'package:domain/feature/otp_verification/entities/otp_verification_request.dart';
import 'package:domain/feature/otp_verification/repositories/otp_authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'otp_authentication_repository_impl_test.mocks.dart';

@GenerateMocks([OtpAutheticationDataSource])
main() {
  late OtpAuthenticationRepositoryImpl otpAuthenticationRepository;
  late MockOtpAutheticationDataSource mockOtpAutheticationDataSource;
  setUp(() {
    mockOtpAutheticationDataSource = MockOtpAutheticationDataSource();
    otpAuthenticationRepository =
        OtpAuthenticationRepositoryImpl(mockOtpAutheticationDataSource);
  });

  test(
      'should call generateOtp on OtpAutheticationDataSource with OTP provided',
      () async {
    final email = 'test&test.com';
    final mobileNo = '123456789';
    final model = OtpGenerationRequestModel(email: email, mobileNo: mobileNo);

    when(mockOtpAutheticationDataSource.generateOtp(request: model)).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponseModel())));

    await otpAuthenticationRepository.generateOtp(
        request: OtpGenerationRequest(email: email, mobileNo: mobileNo));

    verify(mockOtpAutheticationDataSource.generateOtp(request: model));

    verifyNoMoreInteractions(mockOtpAutheticationDataSource);
  });
  test('should call verifyOtp on OtpAutheticationDataSource with OTP provided',
      () async {
    final otp = '1234';
    final model = OtpVerificationRequestModel(otp);

    when(mockOtpAutheticationDataSource.verifyOtp(request: model)).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponseModel())));

    await otpAuthenticationRepository.verifyOtp(
        request: OtpVerificationRequest(otp));

    verify(mockOtpAutheticationDataSource.verifyOtp(request: model));

    verifyNoMoreInteractions(mockOtpAutheticationDataSource);
  });
}
