// import 'package:domain/core/utils/helper_functions.dart';
import 'package:domain/feature/notifications/entity/notification_item.dart';
import 'package:domain/feature/notifications/entity/transaction_status.dart';
import 'package:domain/feature/notifications/usecases/get_notifications.dart';
import 'package:domain/feature/notifications/usecases/update_notification_read_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/core/services/alert_service.dart';

@injectable
class NotificationListPageController extends GetxController {
  final GetNotifications _getNotifications;
  final UpdateNotificationReadStatus _updateNotificationReadStatus;
  final AlertService _alertService;
  List<NotificationItem> notificationItemsList = [];
  var busy = false.obs;

  NotificationListPageController(
    this._getNotifications,
    this._updateNotificationReadStatus,
    this._alertService,
  );

  @override
  onInit() {
    super.onInit();
    initGetNotification();
  }

  initGetNotification() async {
    busy(true);
    var response = await _getNotifications(GetNotificationsParams());

    response.fold(
        (l) => _alertService.showAlertSnackbar(
            title: '', message: l.message ?? ''),
        (r) => notificationItemsList = r);
    busy(false);
  }

  updateNotificationStatus(int id) async {
    await _updateNotificationReadStatus(
        UpdateNotificationReadStatusParams(notificationId: id));
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

  //   1 - Inprogress
// 2 - Success
// 3 - Declined
// 4 - Awaiting
// 5 - Cancelled
// 6 - Refunded

  String transactionStatusToStringInDetail(TransactionStatus status) {
    String s;
    switch (status.code) {
      case 1:
        s = 'transfer_money_is_in_progress'.tr;
        break;
      case 2:
        s = 'you_have_successfully_transfered_money'.tr;
        break;
      case 3:
        s = 'transaction_failed'.tr;
        break;
      case 4:
        s = 'transaction_awaiting'.tr;
        break;
      case 5:
        s = 'transaction_cancelled'.tr;
        break;
      case 6:
        s = 'transaction_refunded'.tr;
        break;
      default:
        s = status.title;
        break;
    }

    return s;
  }

  // String paymentModeToString(PaymentMode pMode) {
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

  String getTransactionStatusImagePath(TransactionStatus pStatus) {
    String path;
    switch (pStatus.code) {
      case 1:
      case 4:
        path = AssetImages.transactionInProcess;
        break;
      case 2:
      case 6:
        path = AssetImages.transactionSuccess;
        break;
      case 3:
      case 5:
        path = AssetImages.transactionFail;
        break;
      default:
        path = '';
        break;
    }
    return path;
  }

  Map<String, dynamic> getTransactionStatusTextAndColor(
      TransactionStatus transactionStatus) {
    Map<String, dynamic> map;

    switch (transactionStatus.code) {
      case 1:
      case 4:
        map = {
          'textColor': Color(0xFFFA6400),
          'bgColor': Color(0xFFF7E7DF),
        };
        break;
      case 2:
      case 6:
        map = {
          'textColor': Color(0xFF417E00),
          'bgColor': Color(0xFFE5ECDD),
        };
        break;
      case 3:
      case 5:
        map = {
          'textColor': Color(0xFFE02020),
          'bgColor': Color(0xFFF4DBDA),
        };
        break;
      default:
        map = {
          'textColor': Color(0xFFFFFFFF),
          'bgColor': Color(0xFF000000),
        };
        break;
    }
    return map;
  }

  String dateToString(DateTime dateTime) {
    var format = 'dd/MM/yyyy';
    return DateFormat(format).format(dateTime);
  }

  String dateTimeToDateTimeString(DateTime dateTime) {
    var format = 'dd MMM yyyy hh:mm a';
    return DateFormat(format).format(dateTime);
  }
}
