import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_status.dart';
import 'package:domain/feature/biometric_authetication/usecases/autheticate_with_biometrics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/biometric_registration/controllers/biometric_registration_page_controller.dart';

import 'biometric_registration_page_controller_test.mocks.dart';

@GenerateMocks([AutheticateWithBiometrics, NavigationService])
main() {
  late BiometricRegistrationPageController biometricRegistrationPageController;
  late MockAutheticateWithBiometrics mockAutheticateWithBiometrics;
  late MockNavigationService mockNavigationService;
  setUp(() {
    mockNavigationService = MockNavigationService();
    mockAutheticateWithBiometrics = MockAutheticateWithBiometrics();

    biometricRegistrationPageController = BiometricRegistrationPageController(
        mockAutheticateWithBiometrics, mockNavigationService);
  });
  test(
      'should redirect to biometricRegistraionSuccessPage when authetication status is true',
      () async {
    when(mockAutheticateWithBiometrics(any)).thenAnswer((realInvocation) =>
        Future.value(Right(BiometricAuthenticationStatus(true))));
    when(mockNavigationService
            .navigate(AppRouts.biometricRegistraionSuccessPage))
        .thenAnswer((realInvocation) => Future.value(null));
    await biometricRegistrationPageController.onProceed();

    verify(mockAutheticateWithBiometrics(any));
    verify(mockNavigationService
        .navigate(AppRouts.biometricRegistraionSuccessPage));
  });
  test(
      'should not redirect to biometricRegistraionSuccessPage when authetication status is false',
      () async {
    when(mockAutheticateWithBiometrics(any)).thenAnswer((realInvocation) =>
        Future.value(Left(BiometricAuthenticationFailure())));
    // when(mockNavigationService
    //     .navigate(AppRouts.biometricRegistraionSuccessPage));
    await biometricRegistrationPageController.onProceed();

    verify(mockAutheticateWithBiometrics(any));
    verifyNever(mockNavigationService
        .navigate(AppRouts.biometricRegistraionSuccessPage));
  });
}
