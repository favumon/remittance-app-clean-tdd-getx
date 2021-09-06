import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/core/shared_widgets/common_loader.dart';
import 'package:remittance_app/core/shared_widgets/label_value_container.dart';
import 'package:remittance_app/feature/transaction_history/controllers/recent_transaction_item_details_page_controller.dart';

class RecentTransactionDetailsBody extends StatelessWidget {
  const RecentTransactionDetailsBody(this.controller, {Key? key})
      : super(key: key);

  final RecentTrasactionItemDetailsPageController controller;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              right: 14,
              left: 14,
              top: (MediaQuery.of(context).size.height / 5) / 2 + 20),
          child: Obx(
            () => controller.busy.value
                ? Center(
                    child: CommonLoader(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'to'.tr,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 10),
                      Text(
                        controller.transactionDetailItem.beneficiaryName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      LabelValueContainer(
                          label: 'bank:'.tr,
                          value: controller.transactionDetailItem.agentName),
                      LabelValueContainer(
                          label: 'branch:'.tr,
                          value: controller.transactionDetailItem.branchName),
                      LabelValueContainer(
                          label: 'city_town:'.tr,
                          value: controller.transactionDetailItem.cityName),
                      LabelValueContainer(
                          label: 'country:'.tr,
                          value: controller.transactionDetailItem.countryName),
                      LabelValueContainer(
                          label: 'swift_code:'.tr,
                          value: controller.transactionDetailItem.swiftCode),
                      LabelValueContainer(
                          label: 'account:'.tr,
                          value:
                              controller.transactionDetailItem.accountNumber),
                      LabelValueContainer(
                          label: 'date:'.tr,
                          value: controller.dateToString(
                              controller.transactionDetailItem.dateTimeOfTxn)),
                      LabelValueContainer(
                          label: 'payment_method:'.tr,
                          value: controller
                              .transactionDetailItem.paymentMode.title),
                      LabelValueContainer(
                          label: 'funds_sent:'.tr,
                          value:
                              '${controller.transactionDetailItem.fundSent} ${controller.transactionDetailItem.lcCurrency}'),
                      LabelValueContainer(
                          label: 'funds_received:'.tr,
                          value:
                              '${controller.transactionDetailItem.fundReceived} ${controller.transactionDetailItem.fcCurrency}'),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
