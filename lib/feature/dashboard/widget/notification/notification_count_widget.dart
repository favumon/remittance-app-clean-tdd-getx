import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/dashboard/widget/notification/notification_count_controller.dart';

class NotificationIconAndCount extends StatelessWidget {
  final _controller = Get.put(getIt<NotificationCountController>());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _controller.navigateToNotifications,
      child: Stack(
        children: [
          SvgPicture.asset(
            image.AssetImages.notificationBell,
            width: 20,
          ),
          Obx(
            () => _controller.notificationCount.value != 0
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                        width: 15,
                        height: 15,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Text(
                          _controller.notificationCount.value.toString(),
                          // _controller.notificationCountList.unreadNotificationCount
                          //     .toString(),
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        )),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
