import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';

class AddNewIdButton extends StatelessWidget {
  const AddNewIdButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Get.toNamed(AppRouts.addNewIdentityPage),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: Text(
          'add_new'.tr,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
