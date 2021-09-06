import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/transaction_history/entities/transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_payment_mode_filter.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_history_list.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_payment_mode_filters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:visibility_detector/visibility_detector.dart';

@injectable
class RecentTrasactionHistoryListPageController extends GetxController {
  final AlertService _alertService;
  final NavigationService _navigationService;
  final GetTransactionHistoryList _getTransactionHistoryList;
  final GetTransactionPaymentModeFilters _getTransactionPaymentModeFilters;

  var busy = false.obs;
  var currentVisibleListSet = <String>{}.obs;

  var filterList = <TransactionPaymentModeFilter>[].obs;
  var selectedFilters = <TransactionPaymentModeFilter>[].obs;

  late List<TransactionItem> transactionItemList;

  RecentTrasactionHistoryListPageController(
    this._alertService,
    this._navigationService,
    this._getTransactionHistoryList,
    this._getTransactionPaymentModeFilters,
  );

  @override
  onInit() {
    super.onInit();

    getFilterList();
    getTransactionHistory([]);
  }

  getFilterList() async {
    (await _getTransactionPaymentModeFilters(NoParams()))
        .fold((l) => null, (r) => filterList(r));
  }

  addOrRemoveFilter(TransactionPaymentModeFilter filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  clearFilter() {
    if (selectedFilters.length == 0) return;
    selectedFilters.clear();
  }

  getTransactionHistory(List<int> filterArray) async {
    busy.value = true;
    var res = await _getTransactionHistoryList(
        GetTransactionHistoryListParams(filterArray));
    busy.value = false;

    res.fold(
        (l) => _alertService.showAlertSnackbar(
            title: '', message: l.message ?? ''),
        (r) => transactionItemList = r);
  }

  TransactionItem get lastTransaction => transactionItemList.first;

  List<TransactionItem> get oneWeekTransaction {
    return transactionItemList
        .skip(1)
        .where((element) =>
            DateTime.now().difference(element.dateTimeOfTxn).inDays < 7)
        .toList();
  }

  List<TransactionItem> get oldTransactions {
    return transactionItemList
        .skip(1)
        .where((element) =>
            DateTime.now().difference(element.dateTimeOfTxn).inDays > 7)
        .toList();
  }

  goToTransactionDetails(int transactionRefId) {
    // _navigationService.navigate(
    //   AppRouts.transactionItemDetailsPage,
    //   arguments: transactionRefId,
    // );
    _navigationService.get.routing.args = transactionRefId;
  }

  // String transactionStatusToString(TransactionStatus status) {
  //   String s;
  //   switch (status) {
  //     case TransactionStatus.InProcess:
  //       s = 'in_process'.tr;
  //       break;
  //     case TransactionStatus.Success:
  //       s = 'successfull'.tr;
  //       break;
  //     case TransactionStatus.Failed:
  //       s = 'failed'.tr;
  //       break;
  //     case TransactionStatus.Pending:
  //       s = 'pending'.tr;
  //       break;
  //     case TransactionStatus.TimeOut:
  //       s = 'timeout'.tr;
  //       break;
  //     case TransactionStatus.UserCancelled:
  //       s = 'cancelled'.tr;
  //       break;
  //     default:
  //       s = 'undefined'.tr;
  //       break;
  //   }

  //   return s;
  // }

  // String getPaymentModeToString(PaymentMode pMode) {
  //   String mode;
  //   switch (pMode) {
  //     case PaymentMode.BankTransfer:
  //       mode = 'bank_transfer'.tr;
  //       break;
  //     case PaymentMode.CashDeposit:
  //       mode = 'cash_deposit'.tr;
  //       break;
  //     case PaymentMode.PayAtCounter:
  //       mode = 'pay_at_counter'.tr;
  //       break;
  //     case PaymentMode.Other:
  //       mode = 'other'.tr;
  //       break;
  //     default:
  //       mode = 'undefined'.tr;
  //       break;
  //   }
  //   return mode;
  // }

  String dateToString(DateTime dateTime) {
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  String timeToString(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  Color transactionStatusTextColor(TransactionStatus status) {
    Color color;
    switch (status.code) {
      case 1:
      case 4:
        color = Color(0xFFFA6400);
        break;
      case 2:
      case 6:
        color = Color(0xFF417E00);
        break;
      case 3:
      case 5:
        color = Color(0xFFE02020);
        break;
      default:
        color = Color(0xFF000000);
        break;
    }

    return color;
  }

  void onVisibilityChanged(VisibilityInfo info, String heading) {
    if (info.visibleFraction * 100 > 0) {
      currentVisibleListSet.add(heading);
    } else {
      currentVisibleListSet.remove(heading);
    }
  }

  String get txnHeading => currentVisibleListSet.contains('last_transaction')
      ? 'last_transaction'
      : currentVisibleListSet.contains('one_week_ago')
          ? 'one_week_ago'
          : 'old_transactions';

  void changeFilter(TransactionPaymentModeFilter? value) {
    if (value == null) {
      clearFilter();
    } else
      addOrRemoveFilter(value);

    getTransactionHistory(
        selectedFilters.map((element) => element.code).toList());
  }
}
