import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/change_password/models/change_password_response_model.dart';
import 'package:data/feature/change_password/repositories/change_password_repository_impl.dart';
import 'package:data/feature/change_password/models/change_password_request_model.dart';
import 'package:data/feature/change_password/datasources/change_password_datasource.dart';

import 'change_password_repository_impl_test.mocks.dart';

@GenerateMocks([ChangePasswordDatasource])
main() {
  late MockChangePasswordDatasource mockChangePasswordDatasource;

  late ChangePasswordRepositoyimpl changePasswordRepositoyimpl;

  setUp(() {
    mockChangePasswordDatasource = MockChangePasswordDatasource();

    changePasswordRepositoyimpl =
        ChangePasswordRepositoyimpl(mockChangePasswordDatasource);
  });

  test('should get ChangePasswordResponse from ChangePasswordDatasource',
      () async {
    final requestModel = ChangePasswordRequestModel(curPwd: '', newPwd: '');
    final request = requestModel;

    final responseModel = ChangePasswordResponseModel();

    when(mockChangePasswordDatasource.changePassword(requestModel))
        .thenAnswer((realInvocation) => Future.value(Right(responseModel)));

    var result =
        await changePasswordRepositoyimpl.changeCurrentPassword(request);

    expect(result, Right(responseModel));

    verify(mockChangePasswordDatasource.changePassword(requestModel));
    verifyNoMoreInteractions(mockChangePasswordDatasource);
  });
}
