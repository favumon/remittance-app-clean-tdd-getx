import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/models/common_api_response_model.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/user_profile/data_sources/user_profile_remote_data_source.dart';
import 'package:data/feature/user_profile/models/update_user_info_model.dart';
import 'package:data/feature/user_profile/models/user_info_model.dart';
import 'package:data/feature/user_profile/models/verify_user_email_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../app_settings/data_sources/app_settings_remote_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late UserProfileRemoteDataSource userProfileRemoteDataSource;
  late MockRemoteApi mockRemoteApi;
  late ApiEndpoints apiEndpoints;
  setUp(() {
    mockRemoteApi = MockRemoteApi();
    userProfileRemoteDataSource =
        UserProfileRemoteDataSource(mockRemoteApi, ApiEndpointsDev());
    apiEndpoints = ApiEndpointsDev();
  });
  test('shoud get UserInfoModel from API', () async {
    final map = jsonDecode(apiResposeMock('user_info.json'));
    final model = UserInfoModel.fromMap(map);

    when(mockRemoteApi.apiGet(apiEndpoints.userProfile))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await userProfileRemoteDataSource.getUserInfo();
    expect(result, Right(model));
    verify(mockRemoteApi.apiGet(apiEndpoints.userProfile));
  });
  test('shoud call API POST to update user profile', () async {
    final model = UpdateUserInfoModel('123456789');

    when(mockRemoteApi.apiPost(apiEndpoints.updateProfile, data: model.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right({})));

    var result = await userProfileRemoteDataSource.updateUserInfo(model);
    expect(result, Right(CommonApiResponseModel()));
    verify(
        mockRemoteApi.apiPost(apiEndpoints.updateProfile, data: model.toMap()));
  });
  test('shoud call API POST for the email to generate verification mail',
      () async {
    final model = VerifyUserEmailModel('test@test.com');

    when(mockRemoteApi.apiPost(apiEndpoints.updateProfile, data: model.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right({})));

    var result = await userProfileRemoteDataSource.sendEmailVerification(model);
    expect(result, Right(CommonApiResponseModel()));
    verify(mockRemoteApi.apiPost(apiEndpoints.sentEmailVerification,
        data: model.toMap()));
  });
}
