import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/currency_converter/models/currency_item_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_request_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_trend_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_trend_request_model.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:core/error/failures.dart';

@lazySingleton
class CurrencyConverterDatasource {
  final RemoteApi _remoteApi;
  final ApiEndpoints _apiEndpoints;

  CurrencyConverterDatasource(this._remoteApi, this._apiEndpoints);

  Future<Either<Failure, List<CurrencyItemModel>>> getCurrencyList() async {
    final response =
        await _remoteApi.apiGet(_apiEndpoints.getProductCurrencyList);

    return response.fold(
        (l) => Left(l),
        (r) => Right((r as List)
            .map<CurrencyItemModel>((e) => CurrencyItemModel.fromMap(e))
            .toList()));
  }

  Future<Either<Failure, CurrencyRateModel>> getCurrencyRate(
      CurrencyRateRequestModel requestModel) async {
    final response = await _remoteApi.apiGet(_apiEndpoints.getCurrencyRate,
        queryParameters: requestModel.toMap());

    return response.fold(
        (l) => Left(l), (r) => Right(CurrencyRateModel.fromMap(r)));
  }

  Future<Either<Failure, List<CurrencyRateTrendModel>>>
      getCurrencyTrendChartValues(
          CurrencyRateTrendRequestModel requestModel) async {
    final response = await _remoteApi.apiGet(
        _apiEndpoints.getCurrencyRateTrendChart,
        queryParameters: requestModel.toMap());

    return response.fold(
        (l) => Left(l),
        (r) => Right((r as List)
            .map<CurrencyRateTrendModel>(
                (e) => CurrencyRateTrendModel.fromMap(e))
            .toList()));
  }
}
