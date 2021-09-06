import 'package:domain/feature/dashboard/quick_link/entity/quick_link_item.dart';
import 'package:domain/feature/dashboard/quick_link/usecases/get_quick_link.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class QuickLinkController extends GetxController {
  final GetQuickLink _getQuickLink;
  final NavigationService _navigationService;
  var quickLinkItem = <QuickLinkItem>[].obs;
  // var busy = false.obs;

  QuickLinkController(this._getQuickLink, this._navigationService);

  @override
  void onInit() {
    super.onInit();
    initGetQuickLink();
  }

  initGetQuickLink() async {
    // busy(true);
    var response = await _getQuickLink(GetQuickLinkParams());
    response.fold((l) => null, (r) => quickLinkItem.value = r);
  }

  String getAvatarText(String name) {
    var split = name.trim().split(' ');
    split = split.where((item) => item.isNotEmpty).toList();

    String avatarText = '';
    for (var text in split) {
      avatarText = avatarText + (text.isNotEmpty ? text[0] : '');
      if (avatarText.length > 2) {
        return avatarText.toUpperCase();
      }
    }
    return avatarText.toUpperCase();
  }

  void navigateToQuickLink() {
    // _navigationService.navigate(AppRouts.notificationListPage);
  }
}
