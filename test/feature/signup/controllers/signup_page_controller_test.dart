import 'package:domain/feature/signup/usecases/submit_signup_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/signup/controllers/signup_page_controller.dart';

import 'signup_page_controller_test.mocks.dart';

@GenerateMocks([NavigationService, SubmitSignupInfo, AlertService])
main() {
  late SignupPageController signupPageController;
  late MockAlertService mockAlertService = MockAlertService();
  late MockSubmitSignupInfo mockSubmitSignupInfo = MockSubmitSignupInfo();
  late MockNavigationService mockNavigationService = MockNavigationService();
  setUp(() {
    signupPageController = SignupPageController(
        mockNavigationService, mockSubmitSignupInfo, mockAlertService);
  });
  test('should not navigate from the screen if form has errors', () async {
    final isFormValid = false;

    signupPageController.autheticateUserUsingOtp(isFormValid, true);

    verifyZeroInteractions(mockNavigationService);
    verifyZeroInteractions(mockAlertService);
  });
  test('should show alert snackbar if terms and conditions not accepted',
      () async {
    final isFormValid = true;
    final isTermsAccepted = false;

    signupPageController.autheticateUserUsingOtp(isFormValid, isTermsAccepted);

    verify(mockAlertService.showAlertSnackbar(
        title: anyNamed('title'), message: anyNamed('message')));

    verifyZeroInteractions(mockNavigationService);
  });
  test(
      'should navigate to Otp verification screen if form is valid and terms and conditions accepted',
      () async {
    final isFormValid = true;
    final isTermsAccepted = true;

    when(mockNavigationService.navigate(AppRouts.otpVerificationPage,
            arguments: anyNamed('arguments')))
        .thenAnswer((realInvocation) => Future.value(true));

    signupPageController.autheticateUserUsingOtp(isFormValid, isTermsAccepted);

    verify(mockNavigationService.navigate(AppRouts.otpVerificationPage,
        arguments: anyNamed('arguments')));
  });
}
