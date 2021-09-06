import 'package:domain/feature/transaction_history/entities/reference_image.dart';
import 'package:domain/feature/transaction_history/validations/reference_image_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/core/shared_widgets/button_normal.dart';
import 'package:remittance_app/core/shared_widgets/button_outlined.dart';
import 'package:remittance_app/core/shared_widgets/common_alert_dailog.dart';
import 'package:remittance_app/core/shared_widgets/common_dialog.dart';
import 'package:remittance_app/core/shared_widgets/common_loader.dart';
import 'package:remittance_app/core/shared_widgets/common_text_field.dart';
import 'package:remittance_app/core/shared_widgets/label_value_container.dart';
import 'package:remittance_app/core/utils/validation_helper.dart';
import 'package:remittance_app/feature/transaction_history/controllers/pending_transaction_item_details_page_controller.dart';
import 'package:remittance_app/feature/transaction_history/widgets/image_picker_transaction.dart';

class PendingTransactionDetailsBody extends StatelessWidget {
  const PendingTransactionDetailsBody(this.controller, {Key? key})
      : super(key: key);

  final PendingTrasactionItemDetailsPageController controller;

  showCompleteTxnDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return CommonDialog(
          child: ReactiveFormBuilder(
            form: () => controller.completeTxnForm,
            builder: (context, form, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'reference_number'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          AssetImages.notificationClose,
                          color: Theme.of(context).primaryColor,
                        ))
                  ],
                ),
                CommonTextField(
                  controlName: 'reference_no',
                  placeHolderText: 'enter_your_reference_number'.tr,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  validationMessages: (control) => generateValidationsMessages(
                      'reference_no'.tr, controller.referenceNumberValidation),
                ),
                SizedBox(height: 8),
                ReactiveFormField<ReferenceImage, ReferenceImage>(
                  formControlName: 'reference_image',
                  validationMessages: (control) => generateValidationsMessages(
                      'reference_image'.tr, ReferenceImageValidation()),
                  builder: (field) {
                    return ImagePickerTransaction(
                      placeHolderText: 'attach_reference_document'.tr,
                      onTap: controller.onPickReferenceImage,
                      field: field,
                    );
                  },
                ),
                SizedBox(height: 8),
                ButtonNormal(
                  onTapped: () {
                    controller.confirmTxn();
                  },
                  buttonText: 'confirm'.tr,
                  isFullWidth: true,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  showCancelTxnDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => CommonDialog(
        child: ReactiveFormBuilder(
          form: () => controller.cancelTxnForm,
          builder: (ctx, form, _) => Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'reason_for_cancellation_?_optional'.tr,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              CommonTextField(
                controlName: 'reason',
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 8),
              ButtonNormal(
                buttonText: 'submit'.tr,
                onTapped: () {
                  Get.back();
                  controller.cancel();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

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
                    children: [
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'to'.tr,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(height: 10),
                            Text(
                              controller.pendingTransactionItemDetails
                                  .beneficiaryName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      LabelValueContainer(
                          label: 'nick_name:'.tr,
                          value: controller
                              .pendingTransactionItemDetails.beneNickName),
                      LabelValueContainer(
                          label: 'bank:'.tr,
                          value: controller
                              .pendingTransactionItemDetails.agentName),
                      LabelValueContainer(
                          label: 'account:'.tr,
                          value: controller
                              .pendingTransactionItemDetails.accountNumber),
                      LabelValueContainer(
                          label: 'date:'.tr,
                          value: controller.dateToString(controller
                              .pendingTransactionItemDetails.dateTimeOfTxn)),
                      LabelValueContainer(
                          label: 'payment_method:'.tr,
                          value: controller
                              .pendingTransactionItemDetails.paymentMode.title),
                      LabelValueContainer(
                          label: 'funds_sent:'.tr,
                          value:
                              '${controller.pendingTransactionItemDetails.fundSent.toString()} ${controller.pendingTransactionItemDetails.lcCurrency}'),
                      LabelValueContainer(
                          label: 'funds_received:'.tr,
                          value:
                              '${controller.pendingTransactionItemDetails.fundReceived.toString()} ${controller.pendingTransactionItemDetails.fcCurrecny}'),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('remaining_time'.tr),
                          SizedBox(height: 6),
                          Obx(() => TimeContainer(
                                controller.time.value.toString(),
                                controller.expired.value
                                    ? Colors.red.withOpacity(.5)
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1),
                              ))
                        ],
                      ),
                      SizedBox(height: 50),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width * .4,
                                child: Obx(
                                  () => ButtonNormal(
                                    buttonText: 'complete'.tr,
                                    onTapped: controller.expired.value
                                        ? null
                                        : () {
                                            showCompleteTxnDialog(context);
                                          },
                                  ),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .4,
                              height: 50,
                              child: Obx(
                                () => ButtonOutlined(
                                  buttonText: 'cancel'.tr,
                                  onTapped: controller.expired.value
                                      ? null
                                      : () {
                                          // showCancelTxnDialog(context);
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => CommonAlertDialog(
                                              message:
                                                  'do_you_want_to_cancel_this_transaction_?'
                                                      .tr,
                                              forwardText: 'yes'.tr,
                                              dismissText: 'no'.tr,
                                              forward: () {
                                                showCancelTxnDialog(context);
                                              },
                                            ),
                                          );
                                        },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class TimeContainer extends StatelessWidget {
  const TimeContainer(this.time, this.bgColor, {Key? key}) : super(key: key);

  final String time;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: time.split(':').asMap().entries.map((e) {
          return Row(
            children: [
              UnitTime(
                digit: e.value,
                unit: e.key == 0
                    ? 'hours'.tr
                    : e.key == 1
                        ? 'minutes'.tr
                        : 'seconds'.tr,
                unitBgColor: bgColor,
              ),
              e.key != 2 ? Colon() : Container()
            ],
          );
        }).toList(),
      ),
    );
  }
}

class UnitTime extends StatelessWidget {
  const UnitTime(
      {Key? key,
      required this.digit,
      required this.unit,
      required this.unitBgColor})
      : super(key: key);

  final String digit;
  final String unit;
  final Color unitBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(
          children: digit.characters
              .map((e) => TimeDigit(e.toString(), unitBgColor))
              .toList(),
        ),
        SizedBox(height: 2),
        Text(unit)
      ],
    ));
  }
}

class TimeDigit extends StatelessWidget {
  final String digit;
  final Color bgColor;

  const TimeDigit(this.digit, this.bgColor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.all(2),
      height: 50,
      width: 50,
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4)),
      child: Center(
        child: Text(
          digit,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontWeight: FontWeight.normal, color: Colors.black54),
        ),
      ),
    );
  }
}

class Colon extends StatelessWidget {
  const Colon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        ':',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.black,
            ),
      ),
    );
  }
}
