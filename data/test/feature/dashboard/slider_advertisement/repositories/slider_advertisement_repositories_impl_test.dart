import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/slider_advertisement/data_sources/slider_advertisement_data_source.dart';
import 'package:data/feature/dashboard/slider_advertisement/model/slider_advertisement_item_model.dart';
import 'package:data/feature/dashboard/slider_advertisement/model/slider_advertisement_request_model.dart';
import 'package:data/feature/dashboard/slider_advertisement/repositories/slider_advertisement_repositories_impl.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_item.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_request.dart';

import 'slider_advertisement_repositories_impl_test.mocks.dart';

@GenerateMocks([SliderAdvertisementDataSource])
main() {
  late MockSliderAdvertisementDataSource mockSliderAdvertisementDataSource;
  late SliderAdvertisementRepositoriesImpl sliderAdvertisementRepositoriesImpl;

  setUp(() {
    mockSliderAdvertisementDataSource = MockSliderAdvertisementDataSource();
    sliderAdvertisementRepositoriesImpl =
        SliderAdvertisementRepositoriesImpl(mockSliderAdvertisementDataSource);
  });

  test(
      'should get list of SliderAdvertisementItem from SliderAdvertisementDataSource',
      () async {
    final requestModel = SliderAdvertisementRequestModel();
    final SliderAdvertisementRequest request = requestModel;
    final itemModelList = [
      SliderAdvertisementModel(adUrl: 'http://qg', adImageUrl: 'http://q.png')
    ];

    final List<SliderAdvertisementItem> itemList = itemModelList;

    when(mockSliderAdvertisementDataSource.getSliderAdvertisement(requestModel))
        .thenAnswer((realInvocation) => Future.value(Right(itemModelList)));

    var result = await sliderAdvertisementRepositoriesImpl
        .getSliderAdvertisement(request);

    expect(result, Right(itemList));

    verify(
        mockSliderAdvertisementDataSource.getSliderAdvertisement(requestModel));
    verifyNoMoreInteractions(mockSliderAdvertisementDataSource);
  });
}
