import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/core/shared_widgets/common_loader.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/notifications/controllers/notifications_list_page_controller.dart';
import 'package:remittance_app/feature/notifications/widgets/notification_item_container.dart';

class NotificationsList extends StatelessWidget {
  final _controller = Get.put(getIt<NotificationListPageController>());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.busy.value
          ? Center(
              child: CommonLoader(),
            )
          : _controller.notificationItemsList.length > 0
              ? ListView.builder(
                  itemCount: _controller.notificationItemsList.length,
                  itemBuilder: (BuildContext ctx, int index) =>
                      NotificationItemContainer(
                    notificationItem: _controller.notificationItemsList[index],
                    controller: _controller,
                  ),
                )
              : Text('no_notifications'.tr),
    );
  }
}
