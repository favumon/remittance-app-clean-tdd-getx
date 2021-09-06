import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/edit_profile/controllers/edit_profile_page_controller.dart';
import 'package:remittance_app/feature/edit_profile/widgets/profile_action_button.dart';
import 'package:remittance_app/feature/edit_profile/widgets/profile_avatar.dart';
import 'package:remittance_app/feature/edit_profile/widgets/verify_email_bottom_sheet.dart';

import '../../../core/shared_widgets/common_text_field.dart';

class EditProfilePage extends StatelessWidget {
  final _controller = Get.put(getIt<EditProfilePageController>());

  final void Function() onNavigateBackFromEditProfile;
  EditProfilePage(this.onNavigateBackFromEditProfile);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onNavigateBackFromEditProfile();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: onNavigateBackFromEditProfile,
              icon: Icon(Icons.arrow_back_ios)),
          brightness: Brightness.dark,
          title: Text('edit_profile'.tr),
          centerTitle: false,
          actions: [
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      child: Text(
                        'done'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: _controller.onFormUpdate)),
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          child: ReactiveFormBuilder(
              form: () => _controller.form,
              builder: (context, form, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                            borderRadius: BorderRadius.circular(80),
                            radius: 120,
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProfileAvatar(),
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        CommonTextField(
                          controlName: 'firstName',
                          prefixText: 'first_name'.tr,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CommonTextField(
                          controlName: 'middleName',
                          prefixText: 'middle_name'.tr,
                        ),
                        CommonTextField(
                          controlName: 'lastName',
                          prefixText: 'last_name'.tr,
                        ),
                        CommonTextField(
                            controlName: 'phoneNumber',
                            prefixText: 'phone_number'.tr,
                            suffix: ProfileActionButton(
                                buttonText: 'update'.tr,
                                onTap: _controller.onPhoneNumberUpdate)),
                        CommonTextField(
                          controlName: 'email',
                          prefixText: 'email'.tr,
                          isReadOnly: true,
                          suffix: ProfileActionButton(
                            buttonText: 'verify'.tr.toUpperCase(),
                            onTap: () => Get.bottomSheet(VerifyEmainBottomSheet(
                                email: form.control('email').value,
                                onSendVerification: () {
                                  Get.back();
                                  _controller.onEmailVerify();
                                })),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
