import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_item.dart';
import 'package:domain/feature/dashboard/slider_advertisement/usecases/get_slider_advertisement.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/feature/dashboard/widget/slider_advertisement/controllers/slider_advertisement_controller.dart';

import 'slider_advertisement_controller_test.mocks.dart';

@GenerateMocks([GetSliderAdvertisement, AlertService])
main() {
  late MockGetSliderAdvertisement mockGetSliderAdvertisement;
  late SliderAdvertisementController sliderAdvertisementController;
  late MockAlertService mockAlertService;

  setUp(() {
    mockGetSliderAdvertisement = MockGetSliderAdvertisement();
    mockAlertService = MockAlertService();
    sliderAdvertisementController = SliderAdvertisementController(
        mockGetSliderAdvertisement, mockAlertService);
  });

  test(
      'should call GetSliderAdvertisement usecase when initGetSilderAds called',
      () {
    final params = GetSliderAdvertisementParams();
    final itemList = [SliderAdvertisementItem(adUrl: '', imageUrl: '')];

    when(mockGetSliderAdvertisement(params))
        .thenAnswer((realInvocation) => Future.value(Right(itemList)));

    sliderAdvertisementController.initGetSilderAds();

    verify(mockGetSliderAdvertisement(params));
  });
}
