import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:domain/feature/currency_converter/entity/currency_rate_trend.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend_request.dart';
import 'package:domain/feature/currency_converter/repositories/currency_converter_repository.dart';
import 'package:domain/feature/currency_converter/usecases/get_currency_trend_chart_values.dart';

import 'get_currency_trend_chart_values_test.mocks.dart';

@GenerateMocks([CurrencyConverterRepository])
main() {
  late MockCurrencyConverterRepository mockCurrencyConverterRepository;
  late GetCurrencyTrendChartValues getCurrencyTrendChartValues;

  setUp(() {
    mockCurrencyConverterRepository = MockCurrencyConverterRepository();
    getCurrencyTrendChartValues =
        GetCurrencyTrendChartValues(mockCurrencyConverterRepository);
  });

  test('Should get List of CurrencyRateTrend from CurrencyConverterRepository',
      () async {
    final listData = [
      CurrencyRateTrend(trendItemList: [], trendPeriodTitle: 'A')
    ];
    final params = GetCurrencyTrendChartParams('A', 'A');
    final request =
        CurrencyRateTrendRequest(fcCode: params.fcCode, lcCode: params.lcCode);

    when(mockCurrencyConverterRepository
            .getCurrencyRateTrendChartValues(request))
        .thenAnswer((realInvocation) => Future.value(Right(listData)));

    var result = await getCurrencyTrendChartValues(params);

    expect(result, Right(listData));
  });
}
