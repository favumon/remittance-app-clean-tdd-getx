import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/shared_widgets/button_normal.dart';
import '../../../di_injection/injection_container.dart';
import '../controllers/biometric_registration_success_page_controller.dart';

class BiometricRegistrationSuccessPage extends StatelessWidget {
  final BiometricRegistrationSuccessPageController controller =
      Get.put(getIt());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F3465),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/right.svg'),
              SizedBox(
                height: 60,
              ),
              Text(
                'right_on'.tr,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'account_is_all_setup'.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .2),
              ButtonNormal(
                buttonText: 'get_started'.tr,
                isFullWidth: true,
                onTapped: controller.onGetStarted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
