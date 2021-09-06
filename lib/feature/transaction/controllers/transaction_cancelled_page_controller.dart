import 'package:domain/feature/transaction_history/entities/pending_transaction_item_details_.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class TransactionCancelledPageController extends GetxController {
  TransactionCancelledPageController(this._navigationService);

  final NavigationService _navigationService;
  late PendingTransactionItemDetails txnDetails;

  @override
  onInit() {
    super.onInit();
    txnDetails = _navigationService.get.arguments;
  }

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

  finishPage() {
    _navigationService.navigateAndReplace(AppRouts.dashboardPage);
  }
}
