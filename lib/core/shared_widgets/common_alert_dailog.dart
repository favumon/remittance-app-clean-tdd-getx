import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/core/shared_widgets/button_normal.dart';
import 'package:remittance_app/core/shared_widgets/button_outlined.dart';
import 'package:remittance_app/core/shared_widgets/common_dialog.dart';

class CommonAlertDialog extends StatelessWidget {
  CommonAlertDialog({
    required this.forward,
    required this.forwardText,
    required this.dismissText,
    this.title = '',
    this.message = '',
  });

  final Function() forward;
  final String forwardText;
  final String dismissText;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      icon: SvgPicture.asset(
        AssetImages.trashBin,
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          if (title != '') SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ButtonNormal(
                    buttonText: forwardText,
                    onTapped: () {
                      Get.back();
                      forward();
                    },
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ButtonOutlined(
                    buttonText: dismissText,
                    onTapped: Get.back,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
