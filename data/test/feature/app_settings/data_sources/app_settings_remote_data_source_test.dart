import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/app_settings/data_sources/app_settings_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_settings_remote_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late AppSettingsRemoteDataSource appSettingsRemoteDataSource;
  late MockRemoteApi mockRemoteApi;
  final apiEndpoints = ApiEndpointsDev();

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    appSettingsRemoteDataSource = AppSettingsRemoteDataSource(
        remoteApi: mockRemoteApi, apiEndpoints: apiEndpoints);
  });
  test('should get appsettings from Remote api', () async {
    final map = jsonDecode(apiResposeMock('app_settings.json'));

    when(mockRemoteApi.apiGet(apiEndpoints.appsettings))
        .thenAnswer((realInvocation) => Future.value(Right(map)));
    await appSettingsRemoteDataSource.getAppSettings();
  });
}
