import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:data/feature/dashboard/slider_advertisement/data_sources/slider_advertisement_data_source.dart';
import 'package:data/feature/dashboard/slider_advertisement/model/slider_advertisement_request_model.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_request.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_item.dart';
import 'package:domain/feature/dashboard/slider_advertisement/repositories/slider_advertisement_repository.dart';

@LazySingleton(as: SliderAdvertisementRepository)
class SliderAdvertisementRepositoriesImpl
    extends SliderAdvertisementRepository {
  final SliderAdvertisementDataSource _sliderAdvertisementDataSource;

  SliderAdvertisementRepositoriesImpl(this._sliderAdvertisementDataSource);

  @override
  Future<Either<Failure, List<SliderAdvertisementItem>>> getSliderAdvertisement(
      SliderAdvertisementRequest sliderAdvertisementRequest) {
    return _sliderAdvertisementDataSource
        .getSliderAdvertisement(SliderAdvertisementRequestModel());
  }
}
