import 'package:dartz/dartz.dart';
import 'package:domain/feature/change_password/entities/change_password_response.dart';
import 'package:domain/feature/change_password/usecases/change_current_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/change_password/controllers/change_password_controller.dart';

import 'change_password_controller_test.mocks.dart';

@GenerateMocks([NavigationService, AlertService, ChangeCurrentPassword])
main() {
  late MockNavigationService mockNavigationService;
  late MockAlertService mockAlertService;
  late MockChangeCurrentPassword mockChangeCurrentPassword;

  late ChangePasswordController changePasswordController;

  setUp(() {
    mockAlertService = MockAlertService();
    mockNavigationService = MockNavigationService();
    mockChangeCurrentPassword = MockChangeCurrentPassword();

    changePasswordController = ChangePasswordController(
        mockNavigationService, mockAlertService, mockChangeCurrentPassword);
  });

  test('should call ChangeCurrentPassword usecase', () async {
    final params =
        ChangeCurrentPasswordParams(currentPassword: '', newPassword: '');

    final response = ChangePasswordResponse();

    when(mockChangeCurrentPassword(params))
        .thenAnswer((realInvocation) => Future.value(Right(response)));
    changePasswordController.changePassword();

    verify(mockChangeCurrentPassword(params));
  });
}
