import 'package:domain/feature/notifications/entity/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/feature/notifications/controllers/notifications_list_page_controller.dart';
import 'package:remittance_app/feature/notifications/widgets/notification_item_bottom_bar.dart';
import 'package:remittance_app/feature/notifications/widgets/notification_item_details.dart';

class NotificationItemContainer extends StatelessWidget {
  final NotificationItem notificationItem;
  final NotificationListPageController controller;

  const NotificationItemContainer(
      {required this.notificationItem, required this.controller});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.updateNotificationStatus(notificationItem.id);
        showDialog(
          context: context,
          builder: (context) =>
              NotificationItemDetails(notificationItem, controller),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'notification_transaction_info'.trParams({
                  'refrenceNo': notificationItem.refrenceNo.toString(),
                  'amount': notificationItem.netAmount.toString(),
                  'transactionStatus': notificationItem.transactionStatus.title
                }),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      height: 1.25,
                    ),
              ),
            ),
            NotificationItemBottomBar(
                date: controller
                    .dateToString(notificationItem.txnCompleteDateTime),
                colors: controller.getTransactionStatusTextAndColor(
                    notificationItem.transactionStatus),
                statusText: notificationItem.transactionStatus.title),
          ],
        ),
      ),
    );
  }
}
