import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_availability.dart';
import 'package:domain/feature/biometric_authetication/usecases/check_biometrics_available.dart';
import 'package:domain/feature/settings/entities/biometric_auth_login_enabled.dart';
import 'package:domain/feature/settings/usecases/change_biometric_auth_login.dart';
import 'package:domain/feature/settings/usecases/get_biometric_auth_enabled.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/settings/controllers/settings_page_controller.dart';

import 'settings_page_controller_test.mocks.dart';

@GenerateMocks([
  NavigationService,
  ChangeBiometricAuthLogin,
  GetBiometricAuthEnabled,
  CheckBiometricsAvailable,
])
main() {
  late MockNavigationService mockNavigationService;
  late MockChangeBiometricAuthLogin mockChangeBiometricAuthLogin;
  late MockGetBiometricAuthEnabled mockGetBiometricAuthEnabled;
  late MockCheckBiometricsAvailable mockCheckBiometricsAvailable;

  late SettingsPageController settingsPageController;

  setUp(() {
    mockNavigationService = MockNavigationService();
    mockChangeBiometricAuthLogin = MockChangeBiometricAuthLogin();
    mockGetBiometricAuthEnabled = MockGetBiometricAuthEnabled();
    mockCheckBiometricsAvailable = MockCheckBiometricsAvailable();

    settingsPageController = SettingsPageController(
      mockNavigationService,
      mockChangeBiometricAuthLogin,
      mockGetBiometricAuthEnabled,
      mockCheckBiometricsAvailable,
    );
  });

  test(
      'should call CheckBiometricsAvailable usecase when checkBioAvailable called',
      () async {
    var noParams = NoParams();
    var biometricAvalability = BiometricAuthenticationAvailability(true);

    when(mockCheckBiometricsAvailable(noParams)).thenAnswer(
        (realInvocation) => Future.value(Right(biometricAvalability)));

    when(mockGetBiometricAuthEnabled(noParams)).thenAnswer(
        (realInvocation) => Future.value(Right(BiometricAuthLoginEnabled())));

    settingsPageController.checkBioAvailable();

    await untilCalled(mockGetBiometricAuthEnabled(NoParams()));

    verify(mockCheckBiometricsAvailable(noParams));
  });

  test('should call GetBiometricAuthEnabled usecase when getBioEnabled called',
      () async {
    var noParams = NoParams();

    when(mockGetBiometricAuthEnabled(noParams)).thenAnswer(
        (realInvocation) => Future.value(Right(BiometricAuthLoginEnabled())));

    settingsPageController.getBioEnabled();

    verify(mockGetBiometricAuthEnabled(noParams));
  });

  test(
      'should call ChangeBiometricAuthLogin usecase when changeBioAuthValue called',
      () async {
    var params = ChangeBiometricAuthLoginParams(true);

    when(mockChangeBiometricAuthLogin(params))
        .thenAnswer((realInvocation) => Future.value(Right(null)));

    settingsPageController.changeBioAuthValue();

    verify(mockChangeBiometricAuthLogin(params));
  });
}
