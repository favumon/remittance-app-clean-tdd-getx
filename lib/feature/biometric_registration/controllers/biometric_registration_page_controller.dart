import 'package:domain/feature/biometric_authetication/usecases/autheticate_with_biometrics.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../../../app_config/routes/app_routes.dart';
import '../../../core/services/navigation_service.dart';

@injectable
class BiometricRegistrationPageController extends GetxController {
  final AutheticateWithBiometrics autheticateWithBiometrics;
  final NavigationService navigationService;

  BiometricRegistrationPageController(
      this.autheticateWithBiometrics, this.navigationService);

  Future<void> onProceed() async {
    var autheticated = await autheticateWithBiometrics(
        AutheticateWithBiometricsParams('Prompt Reason'));

    autheticated.fold(
        (l) => null,
        (r) => navigationService
            .navigate(AppRouts.biometricRegistraionSuccessPage));
  }

  void onSkip() {
    navigationService.navigateAndClearStackUntil(AppRouts.loginPage);
  }
}
