import 'package:domain/feature/login/validation/user_name_validation.dart';
import 'package:domain/feature/signup/entities/signup_info.dart';
import 'package:domain/feature/signup/usecases/submit_signup_info.dart';
import 'package:domain/feature/signup/validation/first_name_validation.dart';
import 'package:domain/feature/signup/validation/last_name_validation.dart';
import 'package:domain/feature/signup/validation/middle_name_validation.dart';
import 'package:domain/feature/signup/validation/phone_number_validation.dart';
import 'package:domain/feature/signup/validation/registration_email_validation.dart';
import 'package:domain/feature/signup/validation/registration_password_validation.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/core/utils/validation_helper.dart';

import '../../../app_config/routes/app_routes.dart';
import '../../../core/services/alert_service.dart';
import '../../../core/services/navigation_service.dart';
import '../../otp_verification/pages/otp_verification_page.dart';

@injectable
class SignupPageController extends GetxController {
  final NavigationService _navigationService;
  final SubmitSignupInfo _submitSignupInfo;
  late SignupInfo _signupInfo;
  final AlertService _dialogService;
  final firstNameValidation = FirstNameValidation();
  final lastNameValidation = LastNameValidation();
  final middleNameValidation = MiddleNameValidation();
  final registrationEmailValidation = RegistrationEmailValidation();
  final phoneNumberValidation = PhoneNumberValidation();
  final userNameValidation = UserNameValidation();
  final registrationPasswordValidation = RegistrationPasswordValidation();
  bool isTermsAccepted = false;

  late TapGestureRecognizer termsAndConditionsTapGestureRecognizer =
      TapGestureRecognizer();

  late FormGroup signupForm;

  final isPasswordObscured = true.obs;
  final isConfirmPasswordObscured = true.obs;
  SignupPageController(
      this._navigationService, this._submitSignupInfo, this._dialogService) {
    initFormFields();
    termsAndConditionsTapGestureRecognizer..onTap = onTermsOfConditionsTapped;
  }

  void initFormFields() {
    signupForm = fb.group({
      'firstName': FormControl<String>(
          validators: generateValidationsNonString(firstNameValidation)),
      'middleName': FormControl<String>(
          validators: generateValidationsNonString(middleNameValidation)),
      'lastName': FormControl<String>(
          validators: generateValidationsNonString(lastNameValidation)),
      'email': FormControl<String>(
          validators:
              generateValidationsNonString(registrationEmailValidation)),
      'phoneNumber': FormControl<String>(
          validators: generateValidationsNonString(phoneNumberValidation)),
      'username': FormControl<String>(
          validators: generateValidationsNonString(phoneNumberValidation)),
      'password': FormControl<String>(
          validators:
              generateValidationsNonString(registrationPasswordValidation)),
      'confirmPassword': FormControl<String>(),
    }, [
      _mustMatch('password', 'confirmPassword')
    ]);
  }

  void onRegister() {
    autheticateUserUsingOtp(checkFormValid(), isTermsAccepted);
  }

  void autheticateUserUsingOtp(bool isFormValid, bool isTermsAccepted) {
    if (!isFormValid) return;
    if (!isTermsAccepted) {
      _dialogService.showAlertSnackbar(
          title: 'T&C not accepted',
          message: 'Please accept terms and conditions before proceeding');
      return;
    }
    _navigationService.navigate(AppRouts.otpVerificationPage,
        arguments: OtpVerificationParams(
            verficationSuccessCallback: onOtpVerify,
            email: 'test@test.com',
            mobileNo: '9865572436'));
  }

  bool checkFormValid() {
    signupForm..markAllAsTouched();
    return signupForm.valid;
  }

  T? getFormValue<T>(String controlName) {
    return (signupForm.controls[controlName] as FormControl<T>).value;
  }

  Future<void> onOtpVerify(String otp) async {
    _dialogService.showLoader();

    await Future.delayed(Duration(seconds: 3));
    _signupInfo = SignupInfo(
      firstName: getFormValue<String>('firstName')!,
      lastName: getFormValue<String>('lastName')!,
      email: getFormValue<String>('email')!,
      middleName: getFormValue<String>('middleName') ?? '',
      password: getFormValue<String>('password')!,
      phoneNumber: getFormValue<String>('phoneNumber')!,
      username: getFormValue<String>('phoneNumber')!,
    );

    var signupResponse =
        await _submitSignupInfo(SignupRequestParams(_signupInfo, otp));

    signupResponse.fold((l) => null, (r) => null);

    _dialogService.hideLoader();
    _navigationService.navigateAndClearStackUntil(AppRouts.pinRegistrationPage);
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

  void onTermsOfConditionsTapped() {
    _navigationService.navigate(AppRouts.termsAndConditionsPage);
  }
}
