import 'package:core/error/failures.dart';
import 'package:data/feature/dashboard/top_exchange_rate/data_sources/top_exchange_rate_data_source.dart';
import 'package:data/feature/dashboard/top_exchange_rate/model/top_exchange_rate_request_model.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_request.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_item.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/repositories/top_exchange_rate_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TopExchangeRateRepository)
class TopExchangeRateRepositoriesImpl extends TopExchangeRateRepository {
  final TopExchangeRateDataSource _topExchangeRateDataSource;

  TopExchangeRateRepositoriesImpl(this._topExchangeRateDataSource);

  @override
  Future<Either<Failure, TopExchangeRateItem>> getTopExchangeRate(
      TopExchangeRateRequest topExchangeRateRequest) {
    return _topExchangeRateDataSource
        .getTopExchangeRate(TopExchangeRateRequestModel());
  }
}
