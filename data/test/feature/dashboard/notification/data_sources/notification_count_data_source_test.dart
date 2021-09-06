import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/notification/data_sources/notification_count_data_source.dart';
import 'package:data/feature/dashboard/notification/model/notification_count_item_model.dart';
import 'package:data/feature/dashboard/notification/model/notifiction_count_request_model.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/remote_api.dart';

import 'notification_count_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late MockRemoteApi mockRemoteApi;
  ApiEndpointsDev apiEndpointsDev = ApiEndpointsDev();

  late NotificationCountDataSource notificationCountDataSource;

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    notificationCountDataSource = NotificationCountDataSource(
        remoteApi: mockRemoteApi, apiEndpoints: apiEndpointsDev);
  });

  test('should get NotificationCountModel from RemoteApi', () async {
    final map = jsonDecode(apiResposeMock('notification_count_response.json'));
    final requestModel = NotificationCountRequestModel();
    final model = NotificationCountModel.fromMap(map);

    when(mockRemoteApi.apiGet(apiEndpointsDev.notificationCount,
            queryParameters: requestModel.toJson()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result =
        await notificationCountDataSource.getNotificationCount(requestModel);

    expect(result, Right(model));

    verify(mockRemoteApi.apiGet(apiEndpointsDev.notificationCount,
        queryParameters: requestModel.toJson()));
  });
}
