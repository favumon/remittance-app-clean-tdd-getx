import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_request.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_item.dart';

abstract class TopExchangeRateRepository {
  Future<Either<Failure, TopExchangeRateItem>> getTopExchangeRate(
      TopExchangeRateRequest topExchangeRateRequest);
}
