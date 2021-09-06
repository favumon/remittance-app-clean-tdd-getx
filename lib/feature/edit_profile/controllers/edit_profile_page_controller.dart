import 'package:domain/feature/user_profile/entities/user_info.dart';
import 'package:domain/feature/user_profile/usecases/update_user_info.dart';
import 'package:domain/feature/user_profile/usecases/verify_user_email.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/core/services/alert_service.dart';

@injectable
class EditProfilePageController extends GetxController {
  final UserInfo userInfo;
  final UpdateUserInfo updateUserInfo;
  final AlertService alertService;
  final VerifyUserEmail verifyUserEmail;
  FormGroup get form => FormGroup({
        'firstName': FormControl<String>(value: userInfo.firstName),
        'middleName': FormControl<String>(value: userInfo.middleName),
        'lastName': FormControl<String>(value: userInfo.lastName),
        'email': FormControl<String>(value: userInfo.email),
        'phoneNumber': FormControl<String>(value: userInfo.phoneNumber),
      });
  EditProfilePageController(this.userInfo, this.updateUserInfo,
      this.alertService, this.verifyUserEmail);

  onPhoneNumberUpdate() async {
    form.control('phoneNumber').unfocus();

    // if (form.valid) {
    //   alertService.showLoader();
    //   var response = await updateUserInfo(
    //       UpdateUserInfoParams(form.control('phoneNumber').value));
    //   alertService.hideLoader();

    //   response.fold(
    //       (l) => null,
    //       (r) => alertService.showAlertSnackbar(
    //           title: 'Success', message: 'Phone number updated'));
    // }

    updatePhoneNumber(form.valid, form.control('phoneNumber').value);
  }

  onFormUpdate() async {
    form.control('phoneNumber').unfocus();

    // if (form.valid) {
    //   alertService.showLoader();
    //   var response = await updateUserInfo(
    //       UpdateUserInfoParams(form.control('phoneNumber').value));
    //   alertService.hideLoader();

    //   response.fold(
    //       (l) => null,
    //       (r) => alertService.showAlertSnackbar(
    //           title: 'Success', message: 'Phone number updated'));
    // }

    updateForm(form.valid, form.control('phoneNumber').value);
  }

  Future<void> updatePhoneNumber(bool isFormValid, String phoneNumber) async {
    if (isFormValid) {
      alertService.showLoader();
      var response = await updateUserInfo(UpdateUserInfoParams(phoneNumber));
      alertService.hideLoader();

      response.fold(
          (l) => null,
          (r) => alertService.showAlertSnackbar(
              title: 'Success', message: 'Phone number updated'));
    }
  }

  Future<void> updateForm(bool isFormValid, String phoneNumber) async {
    if (isFormValid) {
      alertService.showLoader();
      var response = await updateUserInfo(UpdateUserInfoParams(phoneNumber));
      alertService.hideLoader();

      response.fold(
          (l) => null,
          (r) => alertService.showAlertSnackbar(
              title: 'Success', message: 'Form updated'));
    }
  }

  void onEmailVerify() {
    verifyUserEmail(VerifyUserEmailParams(form.control('email').value));
  }
}
