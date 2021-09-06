import 'package:domain/feature/notifications/entity/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/core/shared_widgets/label_value_container.dart';
import 'package:remittance_app/feature/notifications/controllers/notifications_list_page_controller.dart';
import 'package:remittance_app/feature/notifications/widgets/notification_details_header.dart';

class NotificationItemDetails extends StatelessWidget {
  final NotificationItem notificationItem;
  final NotificationListPageController controller;

  const NotificationItemDetails(this.notificationItem, this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  NotificationDetailsHeader(
                    imagePath: controller.getTransactionStatusImagePath(
                        notificationItem.transactionStatus),
                    statusText: notificationItem.transactionStatus.title,
                    statusTextInDetail:
                        controller.transactionStatusToStringInDetail(
                            notificationItem.transactionStatus),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color: Colors.grey.shade100,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${notificationItem.lcCurrencyCode} ${notificationItem.netAmount.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 12),
                        Text(
                          controller
                              .dateToString(notificationItem.dateTimeofTxn),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  LabelValueContainer(
                    label: 'request_reference_number'.tr,
                    value: notificationItem.refrenceNo.toString(),
                  ),
                  LabelValueContainer(
                    label: 'tt_number_for_completed_txns'.tr,
                    value: notificationItem.ttNumber.toString(),
                  ),
                  LabelValueContainer(
                    label: 'payment_mode'.tr,
                    value: notificationItem.paymentMode.title,
                  ),
                  LabelValueContainer(
                    label: 'beneficiary_name'.tr,
                    value: notificationItem.beneficiaryName,
                  ),
                  LabelValueContainer(
                    label: 'bank_agent_name'.tr,
                    value: notificationItem.agentName,
                  ),
                  LabelValueContainer(
                    label: 'ifsc_or_swift_code'.tr,
                    value: notificationItem.swiftCode,
                  ),
                  LabelValueContainer(
                    label: 'account_number'.tr,
                    value: notificationItem.accountNo,
                  ),
                  LabelValueContainer(
                    label: 'transaction_date_and_time'.tr,
                    value: controller.dateTimeToDateTimeString(
                        notificationItem.dateTimeofTxn),
                  ),
                  LabelValueContainer(
                    label: 'status'.tr,
                    value: notificationItem.transactionStatus.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LabelValueContainer(
                    label: 'fc_amount'.tr,
                    value:
                        '${notificationItem.fcAmount.toString()} ${notificationItem.fcCurrencyCode}',
                  ),
                  LabelValueContainer(
                    label: 'rate_applied'.tr,
                    value: notificationItem.rate.toString(),
                  ),
                  LabelValueContainer(
                    label: 'equivalent_lc_value'.tr,
                    value: notificationItem.lcAmount.toString(),
                  ),
                  LabelValueContainer(
                    label: 'charges'.tr,
                    value: notificationItem.charges.toString(),
                  ),
                  LabelValueContainer(
                    label: 'vat'.tr,
                    value: notificationItem.vat.toString(),
                  ),
                  LabelValueContainer(
                    label: 'discount_if_any:'.tr,
                    value: notificationItem.discount.toString(),
                  ),
                  LabelValueContainer(
                    label: 'net_amount'.tr,
                    value:
                        '${notificationItem.netAmount.toString()} ${notificationItem.lcCurrencyCode}',
                  ),
                  LabelValueContainer(
                    label: 'disbursal_mode'.tr,
                    value: notificationItem.disbursalMode.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IconButton(
                      icon: SvgPicture.asset(AssetImages.notificationClose),
                      onPressed: () => Get.back()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
