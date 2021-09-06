import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/core/remote_api.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/feature/dashboard/top_exchange_rate/data_sources/top_exchange_rate_data_source.dart';
import 'package:data/feature/dashboard/top_exchange_rate/model/top_exchange_rate_item_model.dart';
import 'package:data/feature/dashboard/top_exchange_rate/model/top_exchange_rate_request_model.dart';

import 'top_exchange_rate_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late MockRemoteApi mockRemoteApi;
  final ApiEndpointsDev apiEndpointsDev = ApiEndpointsDev();
  late TopExchangeRateDataSource topExchangeRateDataSource;

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    topExchangeRateDataSource = TopExchangeRateDataSource(
      apiEndpoints: apiEndpointsDev,
      remoteApi: mockRemoteApi,
    );
  });

  test('should get TopExchangeRateModel from RemoteApi', () async {
    final requestModel = TopExchangeRateRequestModel();

    final map = jsonDecode(apiResposeMock('top_exchange_rate_response.json'));
    final itemModel = TopExchangeRateModel.fromMap(map);

    when(mockRemoteApi.apiGet(apiEndpointsDev.topExchageRate,
            queryParameters: requestModel.toJson()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result =
        await topExchangeRateDataSource.getTopExchangeRate(requestModel);

    expect(result, Right(itemModel));

    verify(mockRemoteApi.apiGet(apiEndpointsDev.topExchageRate,
        queryParameters: requestModel.toJson()));
  });
}
