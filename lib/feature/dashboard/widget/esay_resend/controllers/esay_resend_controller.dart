import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_item.dart';
import 'package:domain/feature/dashboard/easy_resend/usecases/get_easy_resend.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class EasyResendController extends GetxController {
  final GetEasyResend _getEasyResend;
  final NavigationService _navigationService;
  List<EasyResendItem> easyResendItem = [];

  var busy = false.obs;
  EasyResendController(this._getEasyResend, this._navigationService);

  @override
  void onInit() {
    super.onInit();
    initGetEasyResend();
  }

  initGetEasyResend() async {
    busy(true);
    var response = await _getEasyResend(GetEasyResendParams());
    response.fold((l) => null, (r) => easyResendItem = r);
    busy(false);
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
