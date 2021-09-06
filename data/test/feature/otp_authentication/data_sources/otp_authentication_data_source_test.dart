import 'package:dartz/dartz.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/models/common_api_response_model.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/otp_authentication/data_sources/otp_authentication_data_source.dart';
import 'package:data/feature/otp_authentication/models/otp_generation_request_model.dart';
import 'package:data/feature/otp_authentication/models/otp_verification_request_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'otp_authentication_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late OtpAutheticationDataSource otpAutheticationDataSource;
  late MockRemoteApi mockRemoteApi;
  final ApiEndpointsDev apiEndpointsDev = ApiEndpointsDev();

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    otpAutheticationDataSource =
        OtpAutheticationDataSource(mockRemoteApi, apiEndpointsDev);
  });

  test('should call apiPost on RemoteApi with email and mobile number provided',
      () async {
    final model = OtpGenerationRequestModel(
        email: 'test@test.com', mobileNo: '123456789');

    final response = <String, dynamic>{};

    when(mockRemoteApi.apiPost(apiEndpointsDev.generateOtp,
            data: model.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(response)));
    final result = await otpAutheticationDataSource.generateOtp(request: model);

    expect(result, Right(CommonApiResponseModel()));

    verify(mockRemoteApi.apiPost(apiEndpointsDev.generateOtp,
        data: model.toMap()));
    verifyNoMoreInteractions(mockRemoteApi);
  });

  test('should call apiPost on RemoteApi with otp provided', () async {
    final model = OtpVerificationRequestModel('1234');

    final response = <String, dynamic>{};

    when(mockRemoteApi.apiPost(apiEndpointsDev.verifyOtp, data: model.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(response)));
    final result = await otpAutheticationDataSource.verifyOtp(request: model);

    expect(result, Right(CommonApiResponseModel()));

    verify(
        mockRemoteApi.apiPost(apiEndpointsDev.verifyOtp, data: model.toMap()));
    verifyNoMoreInteractions(mockRemoteApi);
  });
}
