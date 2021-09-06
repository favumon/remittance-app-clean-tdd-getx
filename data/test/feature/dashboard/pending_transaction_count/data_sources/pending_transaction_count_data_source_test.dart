import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/pending_transaction_count/data_sources/pending_transaction_count_data_source.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/dashboard/pending_transaction_count/model/pending_transaction_count_item_model.dart';
import 'package:data/feature/dashboard/pending_transaction_count/model/pending_transaction_count_request_model.dart';

import 'pending_transaction_count_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late MockRemoteApi mockRemoteApi;
  final ApiEndpointsDev apiEndpointsDev = ApiEndpointsDev();

  late PendingTransactionCountDataSource pendingTransactionCountDataSource;

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    pendingTransactionCountDataSource = PendingTransactionCountDataSource(
      remoteApi: mockRemoteApi,
      apiEndpoints: apiEndpointsDev,
    );
  });

  test('should get PendingTransactionCountModel from RemoteApi', () async {
    final map =
        jsonDecode(apiResposeMock('pending_transaction_count_response.json'));
    final requestModel = PendingTransactionCountRequestModel();

    final model = PendingTransactionCountModel.fromMap(map);

    when(mockRemoteApi.apiGet(apiEndpointsDev.pendingTransactionCount,
            queryParameters: requestModel.toJson()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await pendingTransactionCountDataSource
        .getPendingTransactionCount(requestModel);

    expect(result, Right(model));

    verify(mockRemoteApi.apiGet(apiEndpointsDev.pendingTransactionCount,
        queryParameters: requestModel.toJson()));
  });
}
