import 'package:domain/core/validation_params.dart';
import 'package:domain/feature/change_password/usecases/change_current_password.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/core/utils/validation_helper.dart';
import 'package:remittance_app/feature/change_password/validations/password_validations.dart';

const CurrentPassword = 'currentPassword';
const NewPassword = 'newPassword';
const ConfirmPassword = 'confirmPassword';

@injectable
class ChangePasswordController extends GetxController {
  late final FormGroup form;
  final passwordValidations = PasswordValidations();

  final NavigationService _navigationService;
  final AlertService _alertService;
  final ChangeCurrentPassword _changeCurrentPassword;

  var currentPasswordObscure = true.obs;
  var newPasswordObscure = true.obs;
  var confirmPasswordObscure = true.obs;

  ChangePasswordController(
    this._navigationService,
    this._alertService,
    this._changeCurrentPassword,
  ) {
    initFormFields();
  }
  void initChangePassword() {
    if (form.valid) {
      changePassword();
    } else
      form.markAllAsTouched();
  }

  changePassword() async {
    this._alertService.showLoader();
    var res = await _changeCurrentPassword(ChangeCurrentPasswordParams(
      currentPassword: '',
      newPassword: '',
    ));
    this._alertService.hideLoader();

    res.fold(
        (l) => _alertService.showAlertSnackbar(
            title: '', message: l.message ?? ''),
        (r) => this._navigationService.navigateBack());
  }

  Map<String, String> validationMessage(
      String fieldName, ValidationParams validationParams) {
    return generateValidationsMessages(fieldName, validationParams);
  }

  void initFormFields() {
    form = fb.group({
      CurrentPassword: generateValidations(passwordValidations),
      NewPassword: generateValidations(passwordValidations),
      ConfirmPassword: generateValidations(passwordValidations),
    }, [
      _mustMatch(NewPassword, ConfirmPassword)
    ]);
  }

  ValidatorFunction _mustMatch(String controlName, String matchingControlName) {
    return (AbstractControl<dynamic> control) {
      final form = control as FormGroup;

      final formControl = form.control(controlName);
      final matchingFormControl = form.control(matchingControlName);

      if (formControl.value != matchingFormControl.value) {
        matchingFormControl.setErrors({'mustMatch': true});

        // force messages to show up as soon as possible
        matchingFormControl.markAsTouched();
      } else {
        matchingFormControl.removeError('mustMatch');
      }

      return null;
    };
  }

  toggleObsure(RxBool passwordFiled) {
    passwordFiled.value = !passwordFiled.value;
  }
}
