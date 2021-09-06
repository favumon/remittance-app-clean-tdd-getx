import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/core/shared_widgets/common_loader.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/dashboard/dashboard_page.dart';
import 'package:remittance_app/feature/transaction_history/controllers/pending_transaction_history_list_page_controller.dart';
import 'package:remittance_app/feature/transaction_history/widgets/pending_transaction_item_container.dart';
import 'package:remittance_app/feature/transaction_history/widgets/transaction_history_fliter.dart';
import 'package:remittance_app/feature/transaction_history/widgets/transaction_list_header.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PendingTransactionHistoryListPage extends StatefulWidget {
  final void Function(
          TransactionHistoryNavigation? transactionHistoryNavigation)
      onNavigateTransactionHistory;

  PendingTransactionHistoryListPage(this.onNavigateTransactionHistory);

  @override
  _PendingTransactionHistoryListPageState createState() =>
      _PendingTransactionHistoryListPageState();
}

class _PendingTransactionHistoryListPageState
    extends State<PendingTransactionHistoryListPage> {
  final _controller =
      Get.put(getIt<PendingTrasactionHistoryListPageController>());

  late ScrollController _scrollController;

  _scrollListener() {
    print('scrolling ${_scrollController.position}');
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Obx(
                    () => Text(
                      _controller.currentVisibleListSet.length > 0
                          ? _controller.txnHeading.tr
                          : '',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TransactionHistoryFilter(
                  filterList: _controller.filterList,
                  changeFilterList: (value) {
                    _controller.changeFilter(value);
                  },
                  selectedFilterList: _controller.selectedFilters,
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Divider(),
          Obx(
            () => _controller.busy.value
                ? Expanded(
                    child: Center(
                      child: CommonLoader(),
                    ),
                  )
                : Expanded(
                    child: ListView(
                    controller: _scrollController,
                    children: [
                      VisibilityDetector(
                        key: UniqueKey(),
                        onVisibilityChanged: (info) => _controller
                            .onVisibilityChanged(info, 'last_transaction'),
                        child: PendingTransactionItemContainer(
                            _controller.lastTransaction,
                            _controller,
                            widget.onNavigateTransactionHistory),
                      ),
                      if (_controller.oneWeekTransaction.length > 0)
                        SizedBox(height: 20),
                      if (_controller.oneWeekTransaction.length > 0)
                        TransactionListHeader('one_week_ago'.tr),
                      if (_controller.oneWeekTransaction.length > 0)
                        VisibilityDetector(
                          key: UniqueKey(),
                          onVisibilityChanged: (info) => _controller
                              .onVisibilityChanged(info, 'one_week_ago'),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: _controller.oneWeekTransaction.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PendingTransactionItemContainer(
                                  _controller.oneWeekTransaction[index],
                                  _controller,
                                  widget.onNavigateTransactionHistory);
                            },
                          ),
                        ),
                      if (_controller.oldTransactions.length > 0)
                        SizedBox(height: 20),
                      if (_controller.oldTransactions.length > 0)
                        TransactionListHeader('old_transactions'.tr),
                      if (_controller.oldTransactions.length > 0)
                        VisibilityDetector(
                          key: UniqueKey(),
                          onVisibilityChanged: (info) => _controller
                              .onVisibilityChanged(info, 'old_transactions'),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: _controller.oldTransactions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PendingTransactionItemContainer(
                                  _controller.oldTransactions[index],
                                  _controller,
                                  widget.onNavigateTransactionHistory);
                            },
                          ),
                        ),
                    ],
                  )
                    // ListView.builder(
                    //   itemCount: _controller.pendingTransactionItemList.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return PendingTransactionItemContainer(
                    //         _controller.pendingTransactionItemList[index],
                    //         _controller);
                    //   },
                    // ),
                    ),
          )
        ],
      ),
    );
  }
}
