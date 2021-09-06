import 'package:dartz/dartz.dart';

import 'package:core/error/failures.dart';
import 'package:domain/feature/currency_converter/entity/currency_item.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_request.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend_request.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend.dart';

abstract class CurrencyConverterRepository {
  Future<Either<Failure, List<CurrencyItem>>> getProductCurrencyList();
  Future<Either<Failure, CurrencyRate>> getCurrencyRate(
      CurrencyRateRequest request);

  Future<Either<Failure, List<CurrencyRateTrend>>>
      getCurrencyRateTrendChartValues(
          CurrencyRateTrendRequest currencyRateTrendRequest);
}
