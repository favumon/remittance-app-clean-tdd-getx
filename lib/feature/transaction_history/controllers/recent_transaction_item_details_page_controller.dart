import 'package:domain/feature/transaction_history/entities/transaction_details_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_details.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class RecentTrasactionItemDetailsPageController extends GetxController {
  final AlertService _alertService;
  final NavigationService _navigationService;
  final GetTransactionDetails _getTransactionDetails;

  var busy = false.obs;

  late TransactionDetailsItem transactionDetailItem;

  RecentTrasactionItemDetailsPageController(
    this._alertService,
    this._navigationService,
    this._getTransactionDetails,
  );

  @override
  onInit() {
    super.onInit();
    var refId = _navigationService.get.arguments;
    getTransactionDetails(refId);
  }

  getTransactionDetails(int refId) async {
    busy.value = true;
    var res = await _getTransactionDetails(GetTransactionDetailsParams(refId));
    busy.value = false;

    res.fold(
        (l) => _alertService.showAlertSnackbar(
            title: '', message: l.message ?? ''),
        (r) => transactionDetailItem = r);
  }

  goBack() {
    _navigationService.navigateBack();
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

  // String transactionStatusToStringDetailed(TransactionStatus status) {
  //   String s;
  //   switch (status) {
  //     case TransactionStatus.InProcess:
  //       s = 'transaction_is_in_process'.tr;
  //       break;
  //     case TransactionStatus.Success:
  //       s = 'transaction_successfull'.tr;
  //       break;
  //     case TransactionStatus.Failed:
  //       s = 'transaction_failed'.tr;
  //       break;
  //     case TransactionStatus.Pending:
  //       s = 'transaction_pending'.tr;
  //       break;
  //     case TransactionStatus.TimeOut:
  //       s = 'transaction_timeout'.tr;
  //       break;
  //     case TransactionStatus.UserCancelled:
  //       s = 'cancelled_by_user'.tr;
  //       break;
  //     default:
  //       s = 'undefined'.tr;
  //       break;
  //   }

  //   return s;
  // }

  // String transactionStatusToImage(TransactionStatus status) {
  //   String assetImage;
  //   switch (status) {
  //     case TransactionStatus.Success:
  //       assetImage = AssetImages.notificationClose;
  //       break;
  //     case TransactionStatus.Failed:
  //       assetImage = AssetImages.notificationClose;
  //       break;
  //     case TransactionStatus.InProcess:
  //       assetImage = AssetImages.notificationClose;
  //       break;
  //     case TransactionStatus.UserCancelled:
  //       assetImage = AssetImages.notificationClose;
  //       break;
  //     case TransactionStatus.TimeOut:
  //       assetImage = AssetImages.notificationClose;
  //       break;
  //     default:
  //       assetImage = AssetImages.notificationClose;
  //       break;
  //   }

  //   return assetImage;
  // }

  String transactionStatusToStringDetailed(TransactionStatus status) {
    String s;

    switch (status.code) {
      case 1:
        s = 'transaction_is_in_process'.tr;
        break;
      case 2:
        s = 'transaction_successfull'.tr;
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

  String transactionStatusToImage(TransactionStatus status) {
    String assetImage;

    switch (status.code) {
      case 1:
      case 4:
        assetImage = AssetImages.txnPending;
        break;
      case 2:
      case 6:
        assetImage = AssetImages.txnSuccess;
        break;
      case 3:
      case 5:
        assetImage = AssetImages.txnFail;
        break;
      default:
        assetImage = '';
        break;
    }

    return assetImage;
  }
}
