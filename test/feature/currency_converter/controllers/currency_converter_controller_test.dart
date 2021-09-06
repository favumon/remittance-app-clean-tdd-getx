import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/currency_converter/entity/currency_item.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend.dart';
import 'package:domain/feature/currency_converter/usecases/get_all_currency_list.dart';
import 'package:domain/feature/currency_converter/usecases/get_currency_rate_trend.dart';
import 'package:domain/feature/currency_converter/usecases/get_currency_trend_chart_values.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/currency_converter/controllers/currency_converter_controller.dart';

import 'currency_converter_controller_test.mocks.dart';

@GenerateMocks([
  NavigationService,
  GetCurrencyRateTrend,
  GetCurrencyTrendChartValues,
  GetAllCurrencyList,
  AlertService
])
main() {
  late MockGetCurrencyRateTrend mockGetCurrencyRateTrend;
  late MockGetCurrencyTrendChartValues mockGetCurrencyTrendChartValues;
  late MockGetAllCurrencyList mockGetAllCurrencyList;
  late MockNavigationService mockNavigationService;
  late MockAlertService mockAlertService;

  late CurrencyConverterController currencyConverterController;

  setUp(() {
    mockNavigationService = MockNavigationService();
    mockGetCurrencyRateTrend = MockGetCurrencyRateTrend();
    mockGetCurrencyTrendChartValues = MockGetCurrencyTrendChartValues();
    mockGetAllCurrencyList = MockGetAllCurrencyList();
    mockAlertService = MockAlertService();

    currencyConverterController = CurrencyConverterController(
        navigationService: mockNavigationService,
        alertService: mockAlertService,
        getAllCurrencyList: mockGetAllCurrencyList,
        getCurrencyRateTrend: mockGetCurrencyRateTrend,
        getCurrencyTrendChartValues: mockGetCurrencyTrendChartValues);
  });

  test('should call GetAllCurrencyList usecase when initGetCurrencyList called',
      () {
    final params = NoParams();

    when(mockGetAllCurrencyList(params))
        .thenAnswer((realInvocation) => Future.value(Right(<CurrencyItem>[
              CurrencyItem(
                  countryName: 'A',
                  currencyCode: 'A',
                  currencyName: 'A',
                  flagCode: 'a',
                  currencyInDecimals: 2)
            ])));

    currencyConverterController.initGetCurrencyList();

    verify(mockGetAllCurrencyList(params));
  });

  test(
      'should call GetCurrencyRateTrend usecase when initCurrencyRate called  and selectedCurrency not null',
      () {
    currencyConverterController.initFormFields();
    currencyConverterController.selectedCurrency.value = CurrencyItem(
        currencyCode: 'A',
        currencyName: 'A',
        countryName: 'A',
        flagCode: 'a',
        currencyInDecimals: 2);
    final params = GetCurrencyRateTrendParams(
        baseCurrencyCode: 'AED', foreignCurrencyCode: 'A');

    when(mockGetCurrencyRateTrend(params)).thenAnswer(
        (realInvocation) => Future.value(Right(CurrencyRate(rate: 1.0))));

    currencyConverterController.initCurrencyRate();

    verify(mockGetCurrencyRateTrend(params));
  });

  test(
      'should call GetCurrencyTrendChartValues usecase when initGetCurrencyList called and selectedCurrency not null',
      () {
    currencyConverterController.selectedCurrency.value = CurrencyItem(
        currencyCode: 'A',
        currencyName: 'A',
        countryName: 'A',
        flagCode: 'a',
        currencyInDecimals: 2);

    final params = GetCurrencyTrendChartParams('AED', 'A');

    when(mockGetCurrencyTrendChartValues(params)).thenAnswer(
        (realInvocation) => Future.value(Right(<CurrencyRateTrend>[])));

    currencyConverterController.initChartValues();

    verify(mockGetCurrencyTrendChartValues(params));
  });
}
