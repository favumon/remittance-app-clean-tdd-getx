import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_request.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_item.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/repositories/top_exchange_rate_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTopExchangeRate
    extends UseCase<TopExchangeRateItem, GetTopExchangeRateParams> {
  final TopExchangeRateRepository _topExchangeRateRepository;

  GetTopExchangeRate(this._topExchangeRateRepository);

  @override
  Future<Either<Failure, TopExchangeRateItem>> call(
      GetTopExchangeRateParams params) async {
    return await _topExchangeRateRepository
        .getTopExchangeRate(TopExchangeRateRequest());
  }
}

class GetTopExchangeRateParams extends Equatable {
  GetTopExchangeRateParams();

  @override
  List<Object?> get props => [];
}
