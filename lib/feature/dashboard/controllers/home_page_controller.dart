import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class HomePageController extends GetxController {
  final NavigationService navigationService;

  HomePageController(this.navigationService) {}

  void navigateToCurrencyGraphPage() {
    navigationService.navigate(AppRouts.currencyConverterGraph);
  }

  void navigateToTxnHistory() {
    navigationService.navigate(AppRouts.transactionHistoryListPage);
  }
}
