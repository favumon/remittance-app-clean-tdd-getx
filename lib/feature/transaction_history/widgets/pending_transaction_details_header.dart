import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/feature/transaction_history/controllers/pending_transaction_item_details_page_controller.dart';

class PendingTransactionDetailsHeader extends StatelessWidget {
  const PendingTransactionDetailsHeader(this.controller, {Key? key})
      : super(key: key);

  final PendingTrasactionItemDetailsPageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ((MediaQuery.of(context).size.height / 5) / 2) * 2,
        width: MediaQuery.of(context).size.width / 1.15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: Colors.black.withAlpha(20),
                  offset: Offset(0, 2))
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Obx(
          () => controller.busy.value
              ? Container()
              : Column(
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height / 5) / 2 - 15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.transactionStatusToStringDetailed(
                                controller.pendingTransactionItemDetails
                                    .transactionStatus),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          FittedBox(
                            child: SvgPicture.asset(
                              controller.transactionStatusToImage(controller
                                  .pendingTransactionItemDetails
                                  .transactionStatus),
                              width:
                                  (MediaQuery.of(context).size.height / 5) - 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height / 5) / 2 - 15,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.orange),
                                child: Text(
                                  controller
                                      .pendingTransactionItemDetails.lcCurrency,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                controller
                                    .pendingTransactionItemDetails.fundSent
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ref_no:'.tr +
                                  controller
                                      .pendingTransactionItemDetails.refrenceId
                                      .toString()),
                              Text(controller.dateToString(controller
                                  .pendingTransactionItemDetails
                                  .dateTimeOfTxn)),
                              Text(controller.timeToString(controller
                                  .pendingTransactionItemDetails.dateTimeOfTxn))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }
}
