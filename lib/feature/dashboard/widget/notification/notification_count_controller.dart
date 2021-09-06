import 'package:domain/feature/dashboard/notification/usecases/get_notifiction_count.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class NotificationCountController extends GetxController {
  final GetNotificationCount _getNotificationCount;
  final NavigationService _navigationService;
  RxInt notificationCount = 0.obs;

  NotificationCountController(
      this._getNotificationCount, this._navigationService);

  @override
  void onInit() {
    super.onInit();
    initGetNotificationCount();
  }

  initGetNotificationCount() async {
    var response = await _getNotificationCount(GetNotificationsParams());
    response.fold((l) => null,
        (r) => notificationCount.value = r.unreadNotificationCount);
  }

  void navigateToNotifications() {
    _navigationService.navigate(AppRouts.notificationListPage);
  }
}
