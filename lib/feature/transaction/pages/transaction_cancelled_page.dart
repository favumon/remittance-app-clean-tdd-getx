import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/core/shared_widgets/label_value_container.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/transaction/controllers/transaction_cancelled_page_controller.dart';

class TransactionCancelledPage extends StatelessWidget {
  TransactionCancelledPage({Key? key}) : super(key: key);

  final controller = Get.put(getIt<TransactionCancelledPageController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetImages.cryingFace,
                color: Theme.of(context).primaryColor,
                height: MediaQuery.of(context).size.width / 4,
                width: MediaQuery.of(context).size.width / 4,
              ),
              SizedBox(height: 30),
              Text(
                'cancelled'.tr,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.red),
              ),
              SizedBox(height: 20),
              Text(
                'transaction_cancellation_confirmed'.tr,
              ),
              SizedBox(height: 30),
              LabelValueContainer(
                  label: 'nick_name:'.tr,
                  value: controller.txnDetails.beneNickName),
              LabelValueContainer(
                  label: 'bank:'.tr, value: controller.txnDetails.agentName),
              LabelValueContainer(
                  label: 'account:'.tr,
                  value: controller.txnDetails.accountNumber),
              LabelValueContainer(
                  label: 'date:'.tr,
                  value: controller
                      .dateToString(controller.txnDetails.dateTimeOfTxn)),
              LabelValueContainer(
                  label: 'payment_method:'.tr,
                  value: controller.txnDetails.paymentMode.title),
              LabelValueContainer(
                  label: 'funds_sent:'.tr,
                  value:
                      '${controller.txnDetails.fundSent.toString()} ${controller.txnDetails.lcCurrency}'),
              LabelValueContainer(
                  label: 'funds_received:'.tr,
                  value:
                      '${controller.txnDetails.fundReceived.toString()} ${controller.txnDetails.fcCurrecny}'),
            ],
          ),
        ),
      ),
    );
  }
}
