import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/biometric_authetication/usecases/check_biometrics_available.dart';
import 'package:domain/feature/settings/usecases/change_biometric_auth_login.dart';
import 'package:domain/feature/settings/usecases/get_biometric_auth_enabled.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class SettingsPageController extends GetxController {
  final NavigationService _navigationService;
  final ChangeBiometricAuthLogin _changeBiometricAuthLogin;
  final GetBiometricAuthEnabled _getBiometricAuthEnabled;
  final CheckBiometricsAvailable _checkBiometricsAvailable;

  var _biometricAuth = false.obs;
  var _bioAvailable = false.obs;

  SettingsPageController(
      this._navigationService,
      this._changeBiometricAuthLogin,
      this._getBiometricAuthEnabled,
      this._checkBiometricsAvailable);

  @override
  onInit() async {
    super.onInit();

    await checkBioAvailable();
  }

  checkBioAvailable() async {
    (await _checkBiometricsAvailable(NoParams())).fold(
      (l) => null,
      (r) {
        _bioAvailable.value = r.isBiometricAvailable;
        if (r.isBiometricAvailable) getBioEnabled();
      },
    );
  }

  getBioEnabled() async {
    var bio = await _getBiometricAuthEnabled(NoParams());

    bio.fold((l) => null, (r) => _biometricAuth.value = true);
  }

  get biometricAuthEnabled => _biometricAuth.value;

  get bioAvailable => _bioAvailable.value;

  set setBiometricAuthEnabled(value) => _biometricAuth.value = value;

  changeBioAuthValue() {
    _biometricAuth.value = !_biometricAuth.value;
    _changeBiometricAuthLogin(
        ChangeBiometricAuthLoginParams(_biometricAuth.value));
  }

  void navigateToChangePassword() {
    _navigationService.navigate(AppRouts.changePasswordPage);
  }

  void navigateToChangeLanguage() {
    _navigationService.navigate(AppRouts.changeLanguage);
  }
}
