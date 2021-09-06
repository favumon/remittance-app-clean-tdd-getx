import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_request.dart';
import 'package:domain/feature/dashboard/slider_advertisement/entity/slider_advertisement_item.dart';

abstract class SliderAdvertisementRepository {
  Future<Either<Failure, List<SliderAdvertisementItem>>> getSliderAdvertisement(
      SliderAdvertisementRequest notificationRequest);
}
