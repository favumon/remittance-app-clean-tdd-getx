import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/change_password/datasources/change_password_datasource.dart';
import 'package:data/feature/change_password/models/change_password_request_model.dart';
import 'package:data/feature/change_password/models/change_password_response_model.dart';

import 'change_password_datasource_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late MockRemoteApi mockRemoteApi;
  late final apiEndpont = ApiEndpointsDev();

  late ChangePasswordDatasource changePasswordDatasource;

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    changePasswordDatasource =
        ChangePasswordDatasource(mockRemoteApi, apiEndpont);
  });

  test(
      'should return a ChangePasswordResponseModel from RemoteApi called with ChangePasswordRequestModel',
      () async {
    final map = <String, dynamic>{};

    final request = ChangePasswordRequestModel(curPwd: '', newPwd: '');

    final response = ChangePasswordResponseModel();

    when(mockRemoteApi.apiPost(apiEndpont.changePassword,
            data: request.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await changePasswordDatasource.changePassword(request);

    expect(result, Right(response));
  });
}
