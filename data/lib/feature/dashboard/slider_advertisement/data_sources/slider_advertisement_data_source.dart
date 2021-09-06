import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:data/core/constants/api_endpoints.dart';
import 'package:core/error/failures.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/dashboard/slider_advertisement/model/slider_advertisement_item_model.dart';
import 'package:data/feature/dashboard/slider_advertisement/model/slider_advertisement_request_model.dart';

@lazySingleton
class SliderAdvertisementDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  SliderAdvertisementDataSource({
    required this.remoteApi,
    required this.apiEndpoints,
  });

  Future<Either<Failure, List<SliderAdvertisementModel>>>
      getSliderAdvertisement(
          SliderAdvertisementRequestModel
              sliderAdvertisementRequestModel) async {
    var response = await remoteApi.apiGet(apiEndpoints.sliderAds,
        queryParameters: sliderAdvertisementRequestModel.toJson());

    return response.fold((l) => Left(l), (r) {
      return Right((r as List)
          .map<SliderAdvertisementModel>(
            (e) => SliderAdvertisementModel.fromMap(e),
          )
          .toList());
    });
  }
}
