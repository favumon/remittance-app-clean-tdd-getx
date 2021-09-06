import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/currency_converter/entity/currency_rate.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_request.dart';
import 'package:domain/feature/currency_converter/repositories/currency_converter_repository.dart';
import 'package:domain/feature/currency_converter/usecases/get_currency_rate_trend.dart';

import 'get_currency_rate_trend_test.mocks.dart';

@GenerateMocks([CurrencyConverterRepository])
main() {
  late MockCurrencyConverterRepository mockCurrencyConverterRepository;
  late GetCurrencyRateTrend getCurrencyRateTrend;

  setUp(() {
    mockCurrencyConverterRepository = MockCurrencyConverterRepository();
    getCurrencyRateTrend =
        GetCurrencyRateTrend(mockCurrencyConverterRepository);
  });

  test('Should get List of CurrencyRate from CurrencyConverterRepository',
      () async {
    final data = CurrencyRate(rate: 1.0);
    final params = GetCurrencyRateTrendParams(
        baseCurrencyCode: 'A', foreignCurrencyCode: 'A');
    final request = CurrencyRateRequest(
        fcCode: params.baseCurrencyCode, lcCode: params.foreignCurrencyCode);

    when(mockCurrencyConverterRepository.getCurrencyRate(request))
        .thenAnswer((realInvocation) => Future.value(Right(data)));

    var result = await getCurrencyRateTrend(params);

    expect(result, Right(data));
  });
}
