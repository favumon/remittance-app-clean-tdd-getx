import 'package:domain/feature/login/validation/password_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/core/shared_widgets/common_text_field.dart';
import 'package:remittance_app/core/utils/validation_helper.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/change_password/controllers/change_password_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage();

  final _controller = Get.put(getIt<ChangePasswordController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('change_password'.tr),
        centerTitle: false,
        brightness: Brightness.dark,
        actions: [
          InkWell(
            onTap: _controller.initChangePassword,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('done'.tr),
            )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              SvgPicture.asset(AssetImages.changePassword),
              SizedBox(height: 30),
              _changePasswordForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _changePasswordForm() {
    return ReactiveFormBuilder(
      form: () => _controller.form,
      builder: (ctx, form, child) => Obx(
        () => Column(
          children: [
            CommonTextField(
              controlName: CurrentPassword,
              prefixText: 'current'.tr,
              isObscure: _controller.currentPasswordObscure.value,
              suffix: IconButton(
                icon: _controller.currentPasswordObscure.value
                    ? SvgPicture.asset(AssetImages.closedEye)
                    : SvgPicture.asset(AssetImages.openedEye),
                onPressed: () => _controller
                    .toggleObsure(_controller.currentPasswordObscure),
              ),
              hintText: 'enter_your_current_password'.tr,
              textInputAction: TextInputAction.next,
              validationMessages: (control) => _controller.validationMessage(
                  'current'.tr, _controller.passwordValidations),
            ),
            SizedBox(height: 8),
            CommonTextField(
              controlName: NewPassword,
              isObscure: _controller.newPasswordObscure.value,
              prefixText: 'new'.tr,
              suffix: IconButton(
                icon: _controller.newPasswordObscure.value
                    ? SvgPicture.asset(AssetImages.closedEye)
                    : SvgPicture.asset(AssetImages.openedEye),
                onPressed: () =>
                    _controller.toggleObsure(_controller.newPasswordObscure),
              ),
              hintText: 'enter_your_new_password'.tr,
              textInputAction: TextInputAction.next,
              validationMessages: (control) => _controller.validationMessage(
                  'new'.tr, _controller.passwordValidations),
            ),
            SizedBox(height: 8),
            CommonTextField(
              controlName: ConfirmPassword,
              isObscure: _controller.confirmPasswordObscure.value,
              prefixText: 'confirm'.tr,
              hintText: 'confirm_your_new_password'.tr,
              suffix: IconButton(
                icon: _controller.confirmPasswordObscure.value
                    ? SvgPicture.asset(AssetImages.closedEye)
                    : SvgPicture.asset(AssetImages.openedEye),
                onPressed: () => _controller
                    .toggleObsure(_controller.confirmPasswordObscure),
              ),
              textInputAction: TextInputAction.done,
              validationMessages: (_) => generateValidationsMessages(
                  'confirm'.tr, PasswordValidation(),
                  matchingFieldName: 'new'.tr),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
