import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/currency_converter/entity/currency_item.dart';
import 'package:domain/feature/currency_converter/repositories/currency_converter_repository.dart';

@lazySingleton
class GetAllCurrencyList extends UseCase<List<CurrencyItem>, NoParams> {
  final CurrencyConverterRepository _repository;

  GetAllCurrencyList(this._repository);

  @override
  Future<Either<Failure, List<CurrencyItem>>> call(NoParams params) {
    return _repository.getProductCurrencyList();
  }
}
