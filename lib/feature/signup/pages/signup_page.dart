import 'package:domain/feature/login/validation/password_validation.dart';
import 'package:domain/feature/login/validation/user_name_validation.dart';
import 'package:domain/feature/signup/validation/first_name_validation.dart';
import 'package:domain/feature/signup/validation/last_name_validation.dart';
import 'package:domain/feature/signup/validation/middle_name_validation.dart';
import 'package:domain/feature/signup/validation/phone_number_validation.dart';
import 'package:domain/feature/signup/validation/registration_email_validation.dart';
import 'package:domain/feature/signup/validation/registration_password_validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/core/shared_widgets/common_text_field.dart';
import 'package:remittance_app/core/utils/validation_helper.dart';
import 'package:remittance_app/feature/signup/widgets/terms_and_conditions_checkbox.dart';
import 'package:remittance_app/feature/signup/widgets/toggle_obscure_button.dart';

import '../../../core/shared_widgets/button_normal.dart';
import '../../../di_injection/injection_container.dart';
import '../controllers/signup_page_controller.dart';

class SignupPage extends StatelessWidget {
  final SignupPageController _controller = Get.put(getIt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
            child: ReactiveFormBuilder(
                form: () => _controller.signupForm,
                builder: (context, _, __) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text('register'.tr,
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.black,
                                      fontSize: 30,
                                    )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'please_fill_the_credentials'.tr,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.grey[700],
                                  ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        CommonTextField(
                          controlName: 'firstName',
                          placeHolderText: 'first_name'.tr,
                          validationMessages: (_) =>
                              generateValidationsMessages(
                                  'first_name'.tr, FirstNameValidation()),
                        ),
                        CommonTextField(
                          controlName: 'middleName',
                          placeHolderText: 'middle_name'.tr,
                          validationMessages: (_) =>
                              generateValidationsMessages(
                                  'middle_name'.tr, MiddleNameValidation()),
                        ),
                        CommonTextField(
                          controlName: 'lastName',
                          placeHolderText: 'last_name'.tr,
                          validationMessages: (_) =>
                              generateValidationsMessages(
                                  'last_name'.tr, LastNameValidation()),
                        ),
                        CommonTextField(
                          controlName: 'email',
                          placeHolderText: 'email'.tr,
                          validationMessages: (_) =>
                              generateValidationsMessages(
                                  'email'.tr, RegistrationEmailValidation()),
                        ),
                        CommonTextField(
                          controlName: 'phoneNumber',
                          placeHolderText: 'phone_number'.tr,
                          textInputType: TextInputType.number,
                          validationMessages: (_) =>
                              generateValidationsMessages(
                                  'phone_number'.tr, PhoneNumberValidation()),
                        ),
                        CommonTextField(
                          controlName: 'username',
                          placeHolderText: 'user_name'.tr,
                          validationMessages: (_) =>
                              generateValidationsMessages(
                                  'user_name'.tr, UserNameValidation()),
                        ),
                        Obx(() => CommonTextField(
                              controlName: 'password',
                              placeHolderText: 'password'.tr,
                              isObscure: _controller.isPasswordObscured.value,
                              suffix: ToggleObscureButton(
                                  _controller.isPasswordObscured),
                              validationMessages: (_) =>
                                  generateValidationsMessages('password'.tr,
                                      RegistrationPasswordValidation()),
                            )),
                        Obx(() => CommonTextField(
                              controlName: 'confirmPassword',
                              placeHolderText: 'confirm_password'.tr,
                              isObscure:
                                  _controller.isConfirmPasswordObscured.value,
                              suffix: ToggleObscureButton(
                                  _controller.isConfirmPasswordObscured),
                              validationMessages: (_) =>
                                  generateValidationsMessages(
                                      'confirm_password'.tr,
                                      PasswordValidation(),
                                      matchingFieldName: 'password'.tr),
                            )),
                        SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            text: 'terms_and_conditions_part1'.tr,
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'terms_and_conditions_part2'.tr,
                                  recognizer: _controller
                                      .termsAndConditionsTapGestureRecognizer,
                                  style: TextStyle(color: Colors.blue)),
                              TextSpan(text: 'terms_and_conditions_part3'.tr),
                              TextSpan(
                                  text: 'terms_and_conditions_part4'.tr,
                                  recognizer: _controller
                                      .termsAndConditionsTapGestureRecognizer,
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                        TermsAndConditionsCheckbox(
                            (value) => _controller.isTermsAccepted = value!),
                        SizedBox(height: 70),
                      ],
                    ),
                  );
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonNormal(
              isFullWidth: true,
              buttonText: 'register'.tr,
              onTapped: _controller.onRegister,
            ),
          )
        ],
      ),
    );
  }
}
