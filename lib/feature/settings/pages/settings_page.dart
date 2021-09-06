import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/settings/controllers/settings_page_controller.dart';

class SettingsPage extends StatelessWidget {
  final _controller = Get.put(getIt<SettingsPageController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('settings'.tr),
        brightness: Brightness.dark,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: SvgPicture.asset(
                AssetImages.phoneWithLock,
                height: 28,
                width: 28,
              ),
              title: Text(
                'biometric'.tr,
                style: Theme.of(context).textTheme.headline6,
              ),
              trailing: Obx(
                () => Switch.adaptive(
                    value: _controller.biometricAuthEnabled,
                    onChanged: _controller.bioAvailable
                        ? (value) {
                            _controller.changeBioAuthValue();
                          }
                        : null),
              ),
            ),
            SizedBox(height: 12),
            ListTile(
              leading: SvgPicture.asset(
                AssetImages.language,
                height: 28,
                width: 28,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'change_language'.tr,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              subtitle: Text(
                  'choose_app_language_in_english_arabic_hindi_malayalam_and_more_.'
                      .tr),
              onTap: _controller.navigateToChangeLanguage,
            ),
            SizedBox(height: 12),
            ListTile(
              leading: SvgPicture.asset(
                AssetImages.lock,
                height: 28,
                width: 28,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'change_password'.tr,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              subtitle: Text(
                  'secure_access_to_your_account_using_a_strong_login_password_.'
                      .tr),
              onTap: _controller.navigateToChangePassword,
            ),
            SizedBox(height: 12),
            ListTile(
              leading: SvgPicture.asset(
                AssetImages.password,
                height: 28,
                width: 28,
              ),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'change_pin'.tr,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              subtitle:
                  Text('using_a_strong_pin_number_for_secure_access_.'.tr),
            ),
            SizedBox(height: 12),
          ],
        ),
      )),
    );
  }
}
