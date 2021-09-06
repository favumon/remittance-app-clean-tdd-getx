import 'package:domain/feature/transaction_history/entities/pending_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/feature/dashboard/dashboard_page.dart';
import 'package:remittance_app/feature/transaction_history/controllers/pending_transaction_history_list_page_controller.dart';
import 'package:remittance_app/feature/transaction_history/widgets/beneficiary_profile_avatar.dart';

class PendingTransactionItemContainer extends StatelessWidget {
  final void Function(
          TransactionHistoryNavigation? transactionHistoryNavigation)
      onNavigateTransactionHistory;

  const PendingTransactionItemContainer(this.pendingTransactionItem,
      this.controller, this.onNavigateTransactionHistory);

  final PendingTransactionItem pendingTransactionItem;
  final PendingTrasactionHistoryListPageController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToPendingTransactionDetails(
            pendingTransactionItem.transactionRefId);
        onNavigateTransactionHistory(
            TransactionHistoryNavigation.pendingTransactionDetail);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BeneFiciaryProfileAvatar(
                    pendingTransactionItem.profileImageUrl,
                    pendingTransactionItem.beneficiaryName
                        .split(' ')
                        .map((e) => e[0].toUpperCase())
                        .join('')
                        .toString()),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      pendingTransactionItem.beneficiaryName,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                        'ref:'.trParams({
                          'ref':
                              pendingTransactionItem.transactionRefId.toString()
                        }),
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 6),
                    Text(pendingTransactionItem.paymentMode.title,
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                            controller.dateToString(
                                pendingTransactionItem.dateTimeOfTxn),
                            style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(width: 8),
                        Text(
                            controller.timeToString(
                                pendingTransactionItem.dateTimeOfTxn),
                            style: Theme.of(context).textTheme.bodyText2),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      pendingTransactionItem.lcAmount.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(width: 2),
                    Text(pendingTransactionItem.lcCurrency,
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  pendingTransactionItem.transactionStatus.title,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: controller.transactionStatusTextColor(
                          pendingTransactionItem.transactionStatus)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
