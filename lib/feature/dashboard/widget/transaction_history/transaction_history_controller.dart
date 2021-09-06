import 'package:domain/feature/dashboard/pending_transaction_count/usecases/get_pending_transaction_count.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class TransactionHistoryContainerController extends GetxController {
  final GetPendingTransactionCount _getPendingTransactionCount;
  final NavigationService _navigationService;

  RxInt pendingTransactionCount = 0.obs;
  var busy = false.obs;

  TransactionHistoryContainerController(
      this._getPendingTransactionCount, this._navigationService);

  @override
  void onInit() {
    super.onInit();
    initGetPendingTransactionCountCount();
  }

  initGetPendingTransactionCountCount() async {
    busy(true);
    var response =
        await _getPendingTransactionCount(GetPendingTransactionCountParams());
    response.fold((l) => null,
        (r) => pendingTransactionCount.value = r.pendingTransactionCount);

    busy(false);
  }

  void navigateToTxnHistory() {
    _navigationService.navigate(AppRouts.transactionHistoryListPage);
  }
}
