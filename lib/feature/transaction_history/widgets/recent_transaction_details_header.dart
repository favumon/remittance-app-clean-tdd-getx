import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/feature/transaction_history/controllers/recent_transaction_item_details_page_controller.dart';

class RecentTransactionDetailsHeader extends StatelessWidget {
  const RecentTransactionDetailsHeader(this.controller, {Key? key})
      : super(key: key);

  final RecentTrasactionItemDetailsPageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ((MediaQuery.of(context).size.height / 5) / 2) * 2,
      width: MediaQuery.of(context).size.width / 1.15,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: 2,
              color: Colors.black12,
              offset: Offset(0, 2),
            )
          ]),
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
                              controller
                                  .transactionDetailItem.transactionStatus),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        FittedBox(
                          child: SvgPicture.asset(
                            controller.transactionStatusToImage(controller
                                .transactionDetailItem.transactionStatus),
                            width:
                                (MediaQuery.of(context).size.height / 5) - 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height / 5) / 2 - 15,
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
                                controller.transactionDetailItem.lcCurrency,
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
                              controller.transactionDetailItem.fundSent
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
                                controller.transactionDetailItem.refrenceId
                                    .toString()),
                            Text(controller.dateToString(controller
                                .transactionDetailItem.dateTimeOfTxn)),
                            Text(controller.timeToString(
                              controller.transactionDetailItem.dateTimeOfTxn,
                            ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
