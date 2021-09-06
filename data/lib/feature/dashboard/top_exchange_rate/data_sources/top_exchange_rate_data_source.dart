import 'package:core/error/failures.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/dashboard/top_exchange_rate/model/top_exchange_rate_item_model.dart';
import 'package:data/feature/dashboard/top_exchange_rate/model/top_exchange_rate_request_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TopExchangeRateDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  TopExchangeRateDataSource({
    required this.remoteApi,
    required this.apiEndpoints,
  });

  Future<Either<Failure, TopExchangeRateModel>> getTopExchangeRate(
      TopExchangeRateRequestModel topExchangeRateRequestModel) async {
    var response = await remoteApi.apiGet(apiEndpoints.topExchageRate,
        queryParameters: topExchangeRateRequestModel.toJson());

    return response.fold(
        (l) => Left(l), (r) => Right(TopExchangeRateModel.fromMap(r)));
  }
}
