import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/feature/dashboard/dashboard_page.dart';
import 'package:remittance_app/feature/transaction_history/pages/pending_transaction_history_list_page.dart';
import 'package:remittance_app/feature/transaction_history/pages/recent_transaction_history_list_page.dart';

class TransactionHistoryPage extends StatefulWidget {
  final void Function(
          TransactionHistoryNavigation? transactionHistoryNavigation)
      onNavigateTransactionHistory;

  final int transactionHistoryTabIndex;

  const TransactionHistoryPage(
      this.onNavigateTransactionHistory, this.transactionHistoryTabIndex);

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage>
    with SingleTickerProviderStateMixin {
  var _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: widget.transactionHistoryTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () =>
              widget.onNavigateTransactionHistory(null), //Get.back,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        title: Text('transaction_history'.tr),
        brightness: Brightness.dark,
      ),
      body: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(5),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              tabs: [
                Tab(
                  text: 'recent_transaction'.tr,
                ),
                Tab(text: 'pending_transaction'.tr),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                RecentTransactionHistoryListPage(
                    widget.onNavigateTransactionHistory),
                PendingTransactionHistoryListPage(
                    widget.onNavigateTransactionHistory)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
