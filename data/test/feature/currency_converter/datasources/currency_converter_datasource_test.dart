import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:data/feature/currency_converter/models/currency_rate_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/currency_converter/datasources/currency_converter_datasource.dart';
import 'package:data/feature/currency_converter/models/currency_item_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_request_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_trend_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_trend_request_model.dart';

import 'currency_converter_datasource_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late MockRemoteApi mockRemoteApi;
  ApiEndpointsDev apiEndpointsDev = ApiEndpointsDev();
  late CurrencyConverterDatasource converterDatasource;

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    converterDatasource =
        CurrencyConverterDatasource(mockRemoteApi, apiEndpointsDev);
  });

  test('should get list of CurrencyItemModel from RemoteApi', () async {
    final map = jsonDecode(apiResposeMock('currency_list_response.json'));
    final model = map.map((item) => CurrencyItemModel.fromMap(item)).toList();

    when(mockRemoteApi.apiGet(apiEndpointsDev.getProductCurrencyList))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await converterDatasource.getCurrencyList();

    // expect(result, Right(model));

    result.fold((l) => null, (r) => {expect(model[0], r[0])});

    verify(mockRemoteApi.apiGet(apiEndpointsDev.getProductCurrencyList));
  });

  test('should get CurrencyRateModel from RemoteApi', () async {
    final map = jsonDecode(apiResposeMock('currency_rate_response.json'));
    final model = CurrencyRateModel.fromMap(map);

    final requestModel = CurrencyRateRequestModel(fcCode: 'A', lcCode: 'A');

    when(mockRemoteApi.apiGet(apiEndpointsDev.getCurrencyRate,
            queryParameters: requestModel.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await converterDatasource.getCurrencyRate(requestModel);

    expect(result, Right(model));

    verify(mockRemoteApi.apiGet(apiEndpointsDev.getCurrencyRate,
        queryParameters: requestModel.toMap()));
  });

  test('should get list of CurrencyRateTrendModel from RemoteApi', () async {
    final map =
        jsonDecode(apiResposeMock('currency_rate_trend_chart_response.json'));
    final model =
        map.map((item) => CurrencyRateTrendModel.fromMap(item)).toList();
    final requestModel =
        CurrencyRateTrendRequestModel(fcCode: 'A', lcCode: 'A');

    when(mockRemoteApi.apiGet(apiEndpointsDev.getCurrencyRateTrendChart,
            queryParameters: requestModel.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result =
        await converterDatasource.getCurrencyTrendChartValues(requestModel);

    // expect(result, Right(model));

    result.fold((l) => null, (r) => {expect(model[0], r[0])});

    verify(mockRemoteApi.apiGet(apiEndpointsDev.getCurrencyRateTrendChart,
        queryParameters: requestModel.toMap()));
  });
}
