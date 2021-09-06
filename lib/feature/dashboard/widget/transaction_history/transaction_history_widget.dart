import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/assets/images/images.dart' as image;
import 'package:remittance_app/core/shared_widgets/common_loader.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/dashboard/widget/transaction_history/transaction_history_controller.dart';

import '../../dashboard_page.dart';

class TransactionHistoryContainer extends StatelessWidget {
  final _controller = Get.put(getIt<TransactionHistoryContainerController>());

  final void Function(TransactionHistoryNavigation transactionHistoryNavigation)
      onNavigateToTransactionHistory;

  TransactionHistoryContainer(this.onNavigateToTransactionHistory);

  @override
  Widget build(BuildContext context) {
    double _paddigSize = MediaQuery.of(context).size.height * .05;
    double _paddingBelow = MediaQuery.of(context).size.width * .02;
    double _containerSendMoneySize = MediaQuery.of(context).size.width * .40;
    return Padding(
      padding: EdgeInsets.only(top: _paddigSize + _paddingBelow),
      child: Container(
        width: _containerSendMoneySize,
        height: _containerSendMoneySize,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black38,
              offset: const Offset(5.0, 5.0),
              blurRadius: 5.0,
              spreadRadius: 1.0)
        ]),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    onNavigateToTransactionHistory(
                        TransactionHistoryNavigation.transactionHistoryList);
                  }, //_controller.navigateToTxnHistory,
                  child: Image.asset(
                    image.AssetImages.sendMoneyContainerBackgroundImage,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, bottom: 16, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .18,
                        height: MediaQuery.of(context).size.width * .18,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).primaryColor
                                    as MaterialColor)
                                .shade900),
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * .045),
                          child: InkWell(
                            onTap: () {
                              onNavigateToTransactionHistory(
                                  TransactionHistoryNavigation
                                      .transactionHistoryList);
                            }, //_controller.navigateToTxnHistory,
                            child: SvgPicture.asset(
                              image.AssetImages.dashTransactionHisIcon,
                              color: Colors.white,
                              alignment: Alignment.center,
                              clipBehavior: Clip.hardEdge,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'transaction_history_cap'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Obx(
                            () => _controller.busy.value
                                ? Container(
                                    height: 10,
                                    child: Center(
                                      child: CommonLoader(),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Row(
                                      children: [
                                        Text('Pending'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                            child: Text(
                                              _controller
                                                  .pendingTransactionCount
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
