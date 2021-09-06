import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/slider_advertisement/data_sources/slider_advertisement_data_source.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/dashboard/slider_advertisement/model/slider_advertisement_item_model.dart';
import 'package:data/feature/dashboard/slider_advertisement/model/slider_advertisement_request_model.dart';

import 'slider_advertisement_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late MockRemoteApi mockRemoteApi;
  late ApiEndpointsDev apiEndpointsDev = ApiEndpointsDev();

  late SliderAdvertisementDataSource sliderAdvertisementDataSource;

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    sliderAdvertisementDataSource = SliderAdvertisementDataSource(
      apiEndpoints: apiEndpointsDev,
      remoteApi: mockRemoteApi,
    );
  });

  test('should get list of SliderAdvertisementModel from RemoteApi', () async {
    final requestModel = SliderAdvertisementRequestModel();

    final map = jsonDecode(apiResposeMock('slider_ads_response.json'));
    final modelList =
        map.map((item) => SliderAdvertisementModel.fromMap(item)).toList();

    when(mockRemoteApi.apiGet(apiEndpointsDev.sliderAds,
            queryParameters: requestModel.toJson()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await sliderAdvertisementDataSource
        .getSliderAdvertisement(requestModel);

    // expect(result, Right(modelList));

    result.fold((l) => null, (r) => {expect(modelList[0], r[0])});

    verify(mockRemoteApi.apiGet(apiEndpointsDev.sliderAds,
        queryParameters: requestModel.toJson()));
  });
}
