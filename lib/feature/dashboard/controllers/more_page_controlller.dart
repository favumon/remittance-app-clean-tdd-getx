import 'package:domain/feature/dashboard/more/usecases/sign_out.dart';
import 'package:domain/feature/user_profile/entities/user_info.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/di_injection/injection_container.dart';

@injectable
class MorePageController extends GetxController {
  final UserInfo _userInfo;
  final NavigationService _navigationService;
  final AlertService _alertService;
  final SignOut _signOut;

  MorePageController(this._userInfo, this._navigationService,
      this._alertService, this._signOut);

  UserInfo get user => _userInfo;

  navigateToEditProfile() {
    this._navigationService.navigate(AppRouts.editProfilePage);
  }

  navigateToIdentity() {
    this._navigationService.navigate(AppRouts.identityListPage);
  }

  void navigateToSettingPage() {
    this._navigationService.navigate(AppRouts.settingsPage);
  }

  void signout() {
    this._signOut(SignoutRequestParams());
    getIt.unregister<UserInfo>();
    this._navigationService.navigateAndClearStackUntil(AppRouts.loginPage);
  }
}
