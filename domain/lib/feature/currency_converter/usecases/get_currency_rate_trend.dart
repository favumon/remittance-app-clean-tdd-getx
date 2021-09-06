import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_request.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate.dart';
import 'package:domain/feature/currency_converter/repositories/currency_converter_repository.dart';

@lazySingleton
class GetCurrencyRateTrend
    extends UseCase<CurrencyRate, GetCurrencyRateTrendParams> {
  final CurrencyConverterRepository _repository;

  GetCurrencyRateTrend(this._repository);

  @override
  Future<Either<Failure, CurrencyRate>> call(
      GetCurrencyRateTrendParams params) {
    return _repository.getCurrencyRate(CurrencyRateRequest(
        lcCode: params.baseCurrencyCode, fcCode: params.foreignCurrencyCode));
  }
}

class GetCurrencyRateTrendParams extends Equatable {
  final String baseCurrencyCode;
  final String foreignCurrencyCode;

  GetCurrencyRateTrendParams(
      {required this.baseCurrencyCode, required this.foreignCurrencyCode});

  @override
  List<Object?> get props => [baseCurrencyCode, foreignCurrencyCode];
}
