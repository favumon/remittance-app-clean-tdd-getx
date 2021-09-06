import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/biometric_authetication/usecases/autheticate_with_biometrics.dart';
import 'package:domain/feature/login/validation/password_validation.dart';
import 'package:domain/feature/login/validation/user_name_validation.dart';
import 'package:domain/feature/user_profile/entities/user_info.dart';
import 'package:domain/feature/user_profile/usecases/get_user_info.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

import '../../../core/utils/validation_helper.dart';

@injectable
class LoginPageController extends GetxController {
  final userNameValidation = UserNameValidation();
  final passwordValidation = PasswordValidation();
  RxBool isObscureText = true.obs;

  toggleObscureText() {
    isObscureText.value = !isObscureText.value;
  }

  LoginPageController(this.getUserInfo, this.getIt, this.navigationService,
      this.alertService, this.autheticateWithBiometrics) {
    initFormFields();
  }
  late final FormGroup form;

  Map<String, String> passwordValidationMessages(FormControl<String> control) {
    return generateValidationsMessages('password'.tr, passwordValidation);
  }

  Map<String, String> emailValidationMessages(FormControl<String> controlName) {
    return generateValidationsMessages('user_name'.tr, userNameValidation);
  }

  void initFormFields() {
    form = fb.group({
      'user_name': generateValidations(userNameValidation),
      'password': generateValidations(passwordValidation),
    });
  }

  final GetUserInfo getUserInfo;
  final GetIt getIt;
  final NavigationService navigationService;
  final AlertService alertService;
  final AutheticateWithBiometrics autheticateWithBiometrics;

  onLogin() async {
    // getIt.registerLazySingleton(() => UserInfo(
    //     firstName: 'Adam',
    //     middleName: 'K',
    //     lastName: 'Jhon',
    //     email: 'test@test.com',
    //     phoneNumber: '9876567654'));
    // navigationService.navigateAndReplace(AppRouts.editProfilePage);
    alertService.showLoader();

    var response = await getUserInfo(NoParams());

    alertService.hideLoader();

    response.fold((l) => null, (r) {
      getIt.registerSingleton<UserInfo>(r);

      navigationService.navigateAndReplace(AppRouts.dashboardPage);
    });
  }

  Future<void> onAutheticateUsingBiometric() async {
    autheticateWithBiometrics(
            AutheticateWithBiometricsParams('Login using Biometric'))
        .then((value) => value.fold((l) => null, (r) {
              if (r.isAutheticated) onLogin();
            }));
  }
}
