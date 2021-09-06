import 'package:domain/feature/intro_slider/entites/slider_item.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';

@injectable
class IntroSliderPageController extends GetxController {
  final NavigationService _navigationService;

  List<SliderItem> sliderList = [
    SliderItem(
        title: 'easy_transaction'.tr,
        imagePath: AssetImages.easyTransaction,
        desc: 'easy_transaction_sub'.tr),
    SliderItem(
        title: 'secure_payments'.tr,
        imagePath: AssetImages.securePayments,
        desc: 'secure_payments_sub'.tr),
    SliderItem(
        title: 'new_features'.tr,
        imagePath: AssetImages.newFeatures,
        desc: 'new_features_sub'.tr),
  ];
  var slideIndex = 0.obs;

  IntroSliderPageController(this._navigationService);

  changeSlider(int index) {
    slideIndex.value = index;
  }

  navigateToSignIn() {
    _navigationService.navigateAndReplace(AppRouts.loginPage);
  }

  navigateToRegister() {
    _navigationService.navigateAndReplace(AppRouts.signupPage);
  }
}
