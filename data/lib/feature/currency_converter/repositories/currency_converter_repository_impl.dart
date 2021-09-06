import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:data/feature/currency_converter/datasources/currency_converter_datasource.dart';
import 'package:data/feature/currency_converter/models/currency_rate_request_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_trend_request_model.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend_request.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_request.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate.dart';
import 'package:domain/feature/currency_converter/entity/currency_item.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/currency_converter/repositories/currency_converter_repository.dart';

@LazySingleton(as: CurrencyConverterRepository)
class CurrencyConverterRepositoryimpl implements CurrencyConverterRepository {
  final CurrencyConverterDatasource _converterDatasource;

  CurrencyConverterRepositoryimpl(this._converterDatasource);

  @override
  Future<Either<Failure, CurrencyRate>> getCurrencyRate(
      CurrencyRateRequest request) {
    return _converterDatasource.getCurrencyRate(CurrencyRateRequestModel(
        lcCode: request.lcCode, fcCode: request.fcCode));
  }

  @override
  Future<Either<Failure, List<CurrencyRateTrend>>>
      getCurrencyRateTrendChartValues(
          CurrencyRateTrendRequest currencyRateTrendRequest) {
    return _converterDatasource.getCurrencyTrendChartValues(
        CurrencyRateTrendRequestModel(
            lcCode: currencyRateTrendRequest.lcCode,
            fcCode: currencyRateTrendRequest.fcCode));
  }

  @override
  Future<Either<Failure, List<CurrencyItem>>> getProductCurrencyList() {
    return _converterDatasource.getCurrencyList();
  }
}
