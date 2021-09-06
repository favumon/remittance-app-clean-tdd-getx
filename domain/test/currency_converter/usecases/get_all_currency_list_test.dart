import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/currency_converter/usecases/get_all_currency_list.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/currency_converter/entity/currency_item.dart';
import 'package:domain/feature/currency_converter/repositories/currency_converter_repository.dart';

import 'get_all_currency_list_test.mocks.dart';

@GenerateMocks([CurrencyConverterRepository])
main() {
  late MockCurrencyConverterRepository mockCurrencyConverterRepository;
  late GetAllCurrencyList getAllCurrencyList;

  setUp(() {
    mockCurrencyConverterRepository = MockCurrencyConverterRepository();
    getAllCurrencyList = GetAllCurrencyList(mockCurrencyConverterRepository);
  });

  test('Should get List of CurrencyItem from CurrencyConverterRepository',
      () async {
    final listdata = [
      CurrencyItem(
          countryName: 'A',
          currencyCode: 'A',
          currencyName: 'A',
          flagCode: 'a',
          currencyInDecimals: 2)
    ];
    final params = NoParams();

    when(mockCurrencyConverterRepository.getProductCurrencyList())
        .thenAnswer((realInvocation) => Future.value(Right(listdata)));

    var result = await getAllCurrencyList(params);

    expect(result, Right(listdata));
  });
}
