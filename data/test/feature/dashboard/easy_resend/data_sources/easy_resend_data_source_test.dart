import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/easy_resend/data_sources/easy_resend_data_source.dart';
import 'package:data/feature/dashboard/easy_resend/model/easy_resend_item_model.dart';
import 'package:data/feature/dashboard/easy_resend/model/easy_resend_request_model.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/remote_api.dart';

import 'easy_resend_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late MockRemoteApi mockRemoteApi;
  late ApiEndpointsDev apiEndpointsDev;
  late EasyResendtDataSource easyResendtDataSource;

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    apiEndpointsDev = ApiEndpointsDev();

    easyResendtDataSource = EasyResendtDataSource(
      remoteApi: mockRemoteApi,
      apiEndpoints: apiEndpointsDev,
    );
  });

  test('should get list of EasyResendItemModel from RemoteApi', () async {
    final map = jsonDecode(apiResposeMock('easy_resend_list_response.json'));
    final requestModel = EasyResendRequestModel();
    final model = map.map((item) => EasyResendItemModel.fromMap(item)).toList();

    when(mockRemoteApi.apiGet(apiEndpointsDev.easyResendList,
            queryParameters: requestModel.toJson()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await easyResendtDataSource.getEasyResend(requestModel);

    // expect(result, Right(model));

    result.fold((l) => null, (r) => {expect(model[0], r[0])});

    verify(mockRemoteApi.apiGet(apiEndpointsDev.easyResendList,
        queryParameters: requestModel.toJson()));
  });
}
