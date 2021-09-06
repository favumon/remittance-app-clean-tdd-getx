import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_item.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_request.dart';
import 'package:domain/feature/dashboard/slider_advertisement/repositories/slider_advertisement_repository.dart';
import 'package:domain/feature/dashboard/slider_advertisement/usecases/get_slider_advertisement.dart';

import 'get_slider_advertisement_test.mocks.dart';

@GenerateMocks([SliderAdvertisementRepository])
main() {
  late MockSliderAdvertisementRepository mockSliderAdvertisementRepository;
  late GetSliderAdvertisement getSliderAdvertisement;

  setUp(() {
    mockSliderAdvertisementRepository = MockSliderAdvertisementRepository();
    getSliderAdvertisement =
        GetSliderAdvertisement(mockSliderAdvertisementRepository);
  });

  test(
      'should get list of SliderAdvertisementItem from SliderAdvertisementRepository',
      () async {
    final request = SliderAdvertisementRequest();
    final params = GetSliderAdvertisementParams();
    final response = [SliderAdvertisementItem(adUrl: '', imageUrl: '')];

    when(mockSliderAdvertisementRepository.getSliderAdvertisement(request))
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    var result = await getSliderAdvertisement(params);

    verify(mockSliderAdvertisementRepository.getSliderAdvertisement(request));

    expect(result, Right(response));
  });
}
