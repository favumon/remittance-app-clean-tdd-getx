import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/quick_link/data_sources/quick_link_data_source.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/dashboard/quick_link/model/quick_link_item_model.dart';
import 'package:data/feature/dashboard/quick_link/model/quick_link_request_model.dart';

import 'quick_link_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late MockRemoteApi mockRemoteApi;
  final ApiEndpointsDev apiEndpointsDev = ApiEndpointsDev();
  late QuickLinkDataSource quickLinkDataSource;

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    quickLinkDataSource = QuickLinkDataSource(
        apiEndpoints: apiEndpointsDev, remoteApi: mockRemoteApi);
  });

  test('should get list of QuickLinkModel from RremoteApi', () async {
    final requestModel = QuickLinkRequestModel();
    final map = jsonDecode(apiResposeMock('quick_link_list_response.json'));

    final modelList = map.map((item) => QuickLinkModel.fromMap(item)).toList();

    when(mockRemoteApi.apiGet(apiEndpointsDev.quickLink,
            queryParameters: requestModel.toJson()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await quickLinkDataSource.getQuickLink(requestModel);

    // expect(result, Right(modelList));
    result.fold((l) => null, (r) => {expect(modelList[0], r[0])});

    verify(mockRemoteApi.apiGet(apiEndpointsDev.quickLink,
        queryParameters: requestModel.toJson()));
  });
}
