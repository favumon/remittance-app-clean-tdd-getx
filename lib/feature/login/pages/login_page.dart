import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../core/shared_widgets/button_normal.dart';
import '../../../core/shared_widgets/common_text_field.dart';
import '../../../di_injection/injection_container.dart';
import '../controllers/login_page_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginPageController _loginPageController =
      Get.put<LoginPageController>(getIt());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ReactiveFormBuilder(
            form: () => _loginPageController.form,
            builder: (context, form, child) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 50,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.bottomCenter,
                                child: FlutterLogo(
                                  size: 200,
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  height: double.infinity,
                                  alignment: Alignment.topCenter,
                                  child: loginTitle())),
                          Expanded(flex: 4, child: loginTextFormField(form)),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  height: double.infinity,
                                  alignment: Alignment.center,
                                  child: faceDetectionImage())),
                        ],
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.bottomCenter, child: loginButton())
                ]),
              );
            }));
  }

  Widget faceDetectionImage() {
    return GestureDetector(
      onTap: _loginPageController.onAutheticateUsingBiometric,
      child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SvgPicture.asset("assets/images/faceid.svg",
              width: 55, height: 55, semanticsLabel: 'Acme Logo')),
    );
  }

  Widget loginTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.center,
            child: Text(
              'sign_in'.tr,
              style: TextStyle(
                  color: Color(0xFF505054),
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.none,
                  fontSize: 22),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Align(
              child: Text(
            'please_fill_the_credentials'.tr,
            style: TextStyle(
                color: Color(0xFF505054),
                decoration: TextDecoration.none,
                fontSize: 18),
          )),
        ),
      ],
    );
  }

  Widget loginTextFormField(FormGroup form) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: Form(
        key: formKey,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTextField(
                controlName: 'user_name',
                validationMessages:
                    _loginPageController.emailValidationMessages,
                onSubmitted: () => form.focus('password'),
                placeHolderText: 'user_name'.tr + '*',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Stack(
                  children: [
                    CommonTextField(
                      controlName: 'password',
                      isObscure: _loginPageController.isObscureText.value,
                      validationMessages:
                          _loginPageController.passwordValidationMessages,
                      placeHolderText: 'password'.tr + '*',
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: 80,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            _loginPageController.toggleObscureText();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              _loginPageController.isObscureText.value
                                  ? 'show'.tr
                                  : 'hide'.tr,
                              style: TextStyle(color: Color(0xFF0091FF)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text('forgot_password?'.tr)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        return ButtonNormal(
          isFullWidth: true,
          buttonText: 'login'.tr,
          onTapped: form.valid ? _loginPageController.onLogin : null,
        );
      },
    );
  }
}
