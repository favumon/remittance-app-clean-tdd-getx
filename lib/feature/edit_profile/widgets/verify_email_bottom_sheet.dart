import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/core/shared_widgets/button_normal.dart';

class VerifyEmainBottomSheet extends StatelessWidget {
  final String email;

  final void Function() onSendVerification;
  const VerifyEmainBottomSheet(
      {required this.email, required this.onSendVerification});

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'verify_your_email_address'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text('verification_link_send_to_email'.trParams({'email': email}),
                style: Theme.of(context).textTheme.subtitle2!),
            SizedBox(
              height: 30,
            ),
            ButtonNormal(
              isFullWidth: true,
              buttonText: 'send_verification_link'.tr,
              onTapped: onSendVerification,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
