import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/dashboard/dashboard_page.dart';
import 'package:remittance_app/feature/transaction_history/controllers/recent_transaction_item_details_page_controller.dart';
import 'package:remittance_app/feature/transaction_history/widgets/recent_transaction_details_body.dart';
import 'package:remittance_app/feature/transaction_history/widgets/recent_transaction_details_header.dart';

class RecentTransactionDetailsPage extends StatelessWidget {
  final _controller =
      Get.put(getIt<RecentTrasactionItemDetailsPageController>());

  final void Function(
          TransactionHistoryNavigation? transactionHistoryNavigation)
      onNavigateTransactionHistory;

  RecentTransactionDetailsPage(this.onNavigateTransactionHistory);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            image.AssetImages.mainBackgroundDash,
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Platform.isIOS
                      //     ?
                      CupertinoButton(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        onPressed: () => onNavigateTransactionHistory(
                            TransactionHistoryNavigation
                                .transactionHistoryList),
                      ),
                      // : IconButton(
                      //     onPressed: _controller.goBack,
                      //     icon: Icon(
                      //       Icons.arrow_back,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      SizedBox(width: 3),
                      Text(
                        'recent_transaction_details'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height / 5) / 2,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.none,
                    children: [
                      RecentTransactionDetailsBody(_controller),
                      Positioned(
                          top: -(MediaQuery.of(context).size.height / 5) / 2,
                          child: RecentTransactionDetailsHeader(_controller)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
