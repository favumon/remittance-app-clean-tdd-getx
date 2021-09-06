import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class TransactionCompletedPageController extends GetxController {
  TransactionCompletedPageController(this._navigationService);

  final NavigationService _navigationService;

  @override
  onInit() {
    super.onInit();
  }

  finishPage() {
    _navigationService.navigateAndReplace(AppRouts.dashboardPage);
  }
}
