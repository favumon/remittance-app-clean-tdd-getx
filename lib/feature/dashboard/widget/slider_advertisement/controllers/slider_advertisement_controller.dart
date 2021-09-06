import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_item.dart';
import 'package:domain/feature/dashboard/slider_advertisement/usecases/get_slider_advertisement.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:url_launcher/url_launcher.dart';

@injectable
class SliderAdvertisementController extends GetxController {
  final GetSliderAdvertisement _getSliderAdvertisement;
  final AlertService _alertService;

  SliderAdvertisementController(
      this._getSliderAdvertisement, this._alertService);

  var silderList = <SliderAdvertisementItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    initGetSilderAds();
  }

  initGetSilderAds() async {
    var response =
        await _getSliderAdvertisement(GetSliderAdvertisementParams());
    response.fold((l) => null, (r) => silderList.value = r);
  }

  openAd(SliderAdvertisementItem item) async {
    if (await canLaunch(item.adUrl)) {
      launch(item.adUrl);
    } else
      this._alertService.showAlertSnackbar(
          title: 'error'.tr, message: 'cant_open_the_advertisement'.tr);
  }
}
