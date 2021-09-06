import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_payment_mode_filter.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:domain/feature/transaction_history/usecases/get_pending_transaction_history_list.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_payment_mode_filters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:visibility_detector/visibility_detector.dart';

@injectable
class PendingTrasactionHistoryListPageController extends GetxController {
  final AlertService _alertService;
  final NavigationService _navigationService;
  final GetPendingTransactionHistoryList _getPendingTransactionHistoryList;
  final GetTransactionPaymentModeFilters _getTransactionPaymentModeFilters;

  var busy = false.obs;
  var currentVisibleListSet = <String>{}.obs;

  var filterList = <TransactionPaymentModeFilter>[].obs;
  var selectedFilters = <TransactionPaymentModeFilter>[].obs;

  late List<PendingTransactionItem> pendingTransactionItemList;

  // List<PaymentMode> paymentModesFilter = [];
  // var selectedFilters = <PaymentMode>[].obs;

  PendingTrasactionHistoryListPageController(
    this._alertService,
    this._navigationService,
    this._getPendingTransactionHistoryList,
    this._getTransactionPaymentModeFilters,
  );

  @override
  onInit() {
    super.onInit();

    // PaymentMode.values.forEach((element) {
    //   paymentModesFilter.add(element);
    // });
    getFilterList();
    getPendingTransactionHistory([]);
  }

  getFilterList() async {
    (await _getTransactionPaymentModeFilters(NoParams()))
        .fold((l) => null, (r) => filterList(r));
  }

  getPendingTransactionHistory(List<int> filterArray) async {
    busy.value = true;
    var res = await _getPendingTransactionHistoryList(
        GetPendingTransactionHistoryListParams(filterArray));
    busy.value = false;

    res.fold(
        (l) => _alertService.showAlertSnackbar(
            title: '', message: l.message ?? ''),
        (r) => pendingTransactionItemList = r);
  }

  PendingTransactionItem get lastTransaction =>
      pendingTransactionItemList.first;

  List<PendingTransactionItem> get oneWeekTransaction {
    return pendingTransactionItemList
        .skip(1)
        .where((element) =>
            DateTime.now().difference(element.dateTimeOfTxn).inDays < 7)
        .toList();
  }

  List<PendingTransactionItem> get oldTransactions {
    return pendingTransactionItemList
        .skip(1)
        .where((element) =>
            DateTime.now().difference(element.dateTimeOfTxn).inDays > 7)
        .toList();
  }

  // addOrRemoveFilter(PaymentMode filter) {
  //   if (selectedFilters.contains(filter)) {
  //     selectedFilters.remove(filter);
  //   } else {
  //     selectedFilters.add(filter);
  //   }
  //   getPendingTransactionHistory();
  // }

  // clearFilter() {
  //   if (selectedFilters.length == 0) return;
  //   selectedFilters.clear();
  //   getPendingTransactionHistory();
  // }

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

  goToPendingTransactionDetails(int transactionRefId) async {
    // var result = await _navigationService.navigate(
    //   AppRouts.pendingTransactionItemDetailsPage,
    //   arguments: transactionRefId,
    // );

    // if (result != null && result) {
    //   getPendingTransactionHistory(
    //       selectedFilters.map((element) => element.code).toList());
    // }

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

  // Color transactionStatusTextColor(TransactionStatus status) {
  //   Color color;
  //   switch (status) {
  //     case TransactionStatus.InProcess:
  //       color = Color(0xFFFA6400);
  //       break;
  //     case TransactionStatus.Success:
  //       color = Color(0xFF417E00);
  //       break;
  //     case TransactionStatus.Failed:
  //       color = Color(0xFFE02020);
  //       break;
  //     case TransactionStatus.Pending:
  //       color = Color(0xFFFA6400);
  //       break;
  //     case TransactionStatus.TimeOut:
  //       color = Color(0xFFE02020);
  //       break;
  //     case TransactionStatus.UserCancelled:
  //       color = Color(0xFFE02020);
  //       break;
  //     default:
  //       color = Color(0xFF000000);
  //       break;
  //   }

  //   return color;
  // }

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

    getPendingTransactionHistory(
        selectedFilters.map((element) => element.code).toList());
  }
}
