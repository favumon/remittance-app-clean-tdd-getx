import 'package:domain/feature/transaction_history/entities/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/feature/dashboard/dashboard_page.dart';
import 'package:remittance_app/feature/transaction_history/controllers/recent_transaction_history_list_page_controller.dart';
import 'package:remittance_app/feature/transaction_history/widgets/beneficiary_profile_avatar.dart';

class RecentTransactionItemContainer extends StatelessWidget {
  final void Function(
          TransactionHistoryNavigation? transactionHistoryNavigation)
      onNavigateTransactionHistory;

  const RecentTransactionItemContainer(
      this.transactionItem, this.controller, this.onNavigateTransactionHistory);

  final TransactionItem transactionItem;
  final RecentTrasactionHistoryListPageController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.goToTransactionDetails(transactionItem.transactionRefId);

        onNavigateTransactionHistory(
            TransactionHistoryNavigation.recenttransactionDetail);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BeneFiciaryProfileAvatar(
                    transactionItem.profileImageUrl,
                    transactionItem.beneficiaryName
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
                      transactionItem.beneficiaryName,
                      style: Theme.of(context).textTheme.headline6!,
                    ),
                    SizedBox(height: 6),
                    Text(
                        'ref:'.trParams({
                          'ref': transactionItem.transactionRefId.toString()
                        }),
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 6),
                    Text(transactionItem.paymentMode.title,
                        style: Theme.of(context).textTheme.bodyText2),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                            controller
                                .dateToString(transactionItem.dateTimeOfTxn),
                            style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(width: 8),
                        Text(
                            controller
                                .timeToString(transactionItem.dateTimeOfTxn),
                            style: Theme.of(context).textTheme.bodyText2),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      transactionItem.lcAmount.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(width: 2),
                    Text(transactionItem.lcCurrency,
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  transactionItem.transactionStatus.title,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: controller.transactionStatusTextColor(
                          transactionItem.transactionStatus)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
