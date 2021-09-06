import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/shared_widgets/button_normal.dart';
import '../../../di_injection/injection_container.dart';
import '../controllers/biometric_registration_page_controller.dart';

class BiometricRegistrationPage extends StatelessWidget {
  final BiometricRegistrationPageController controller = Get.put(getIt());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFF2F3465),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/face_id.svg'),
                SizedBox(width: 20),
                SvgPicture.asset('assets/images/touchid.svg'),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'face_id_or_touch_id'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 30),
            Text(
              'autheticate_using_faceid_touchid_instead_password'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .18),
            ButtonNormal(
              buttonText: 'proceed'.tr,
              isFullWidth: true,
              onTapped: controller.onProceed,
            ),
            SizedBox(height: 10),
            TextButton(
                onPressed: controller.onSkip,
                child: Text(
                  'skip_this_step'.tr,
                  style: TextStyle(color: Colors.white),
                )),
            Spacer(),
            Text(
              'we_not_recommend_faceid_if_twin_or_sibilings_like_you'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1.4),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
