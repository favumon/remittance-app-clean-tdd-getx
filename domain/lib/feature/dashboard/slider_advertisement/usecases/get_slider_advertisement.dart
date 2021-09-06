import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_request.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_item.dart';
import 'package:domain/feature/dashboard/slider_advertisement/repositories/slider_advertisement_repository.dart';

@lazySingleton
class GetSliderAdvertisement extends UseCase<List<SliderAdvertisementItem>,
    GetSliderAdvertisementParams> {
  final SliderAdvertisementRepository _sliderAdvertisementRepository;

  GetSliderAdvertisement(this._sliderAdvertisementRepository);

  @override
  Future<Either<Failure, List<SliderAdvertisementItem>>> call(
      GetSliderAdvertisementParams params) async {
    return await _sliderAdvertisementRepository
        .getSliderAdvertisement(SliderAdvertisementRequest());
  }
}

class GetSliderAdvertisementParams extends Equatable {
  GetSliderAdvertisementParams();

  @override
  List<Object?> get props => [];
}
