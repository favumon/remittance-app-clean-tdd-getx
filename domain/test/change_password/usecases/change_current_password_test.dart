import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/change_password/entities/change_password_response.dart';
import 'package:domain/feature/change_password/entities/change_password_request.dart';
import 'package:domain/feature/change_password/repositories/change_password_repository.dart';
import 'package:domain/feature/change_password/usecases/change_current_password.dart';

import 'change_current_password_test.mocks.dart';

@GenerateMocks([ChangePasswordRepository])
main() {
  late MockChangePasswordRepository mockChangePasswordRepository;

  late ChangeCurrentPassword changeCurrentPassword;

  setUp(() {
    mockChangePasswordRepository = MockChangePasswordRepository();
    changeCurrentPassword = ChangeCurrentPassword(mockChangePasswordRepository);
  });

  test('should get ChangePasswordResponse on ChangePasswordRepository',
      () async {
    final params =
        ChangeCurrentPasswordParams(currentPassword: '', newPassword: '');
    final request = ChangePasswordRequest(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
    );

    when(mockChangePasswordRepository.changeCurrentPassword(request))
        .thenAnswer(
            (realInvocation) => Future.value(Right(ChangePasswordResponse())));

    var result = await changeCurrentPassword(params);

    expect(result, Right(ChangePasswordResponse()));
  });
}
