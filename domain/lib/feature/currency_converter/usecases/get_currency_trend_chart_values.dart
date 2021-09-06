import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend_request.dart';
import 'package:domain/feature/currency_converter/repositories/currency_converter_repository.dart';

@lazySingleton
class GetCurrencyTrendChartValues
    extends UseCase<List<CurrencyRateTrend>, GetCurrencyTrendChartParams> {
  final CurrencyConverterRepository _repository;

  GetCurrencyTrendChartValues(this._repository);

  @override
  Future<Either<Failure, List<CurrencyRateTrend>>> call(
      GetCurrencyTrendChartParams params) {
    return _repository.getCurrencyRateTrendChartValues(
        CurrencyRateTrendRequest(lcCode:params.lcCode,fcCode: params.fcCode));
  }
}

class GetCurrencyTrendChartParams extends Equatable {
  final String lcCode;
  final String fcCode;

  GetCurrencyTrendChartParams(this.lcCode, this.fcCode);

  @override
  List<Object?> get props => [lcCode, fcCode];
}
