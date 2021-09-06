import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/currency_converter/datasources/currency_converter_datasource.dart';
import 'package:data/feature/currency_converter/repositories/currency_converter_repository_impl.dart';
import 'package:data/feature/currency_converter/models/currency_item_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_request_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_trend_item_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_trend_model.dart';
import 'package:data/feature/currency_converter/models/currency_rate_trend_request_model.dart';
import 'package:domain/feature/currency_converter/entity/currency_item.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_request.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend.dart';
import 'package:domain/feature/currency_converter/entity/currency_rate_trend_request.dart';

import 'currency_converter_repository_impl_test.mocks.dart';

@GenerateMocks([CurrencyConverterDatasource])
main() {
  late MockCurrencyConverterDatasource mockCurrencyConverterDatasource;
  late CurrencyConverterRepositoryimpl currencyConverterRepositoryimpl;

  setUp(() {
    mockCurrencyConverterDatasource = MockCurrencyConverterDatasource();
    currencyConverterRepositoryimpl =
        CurrencyConverterRepositoryimpl(mockCurrencyConverterDatasource);
  });

  test('should get list of CurrencyItem from CurrencyConverterDatasource',
      () async {
    final currencyItemModelList = [
      CurrencyItemModel(
        currencyCode: 'A',
        currencyName: 'A',
        countryName: 'A',
        flagCode: 'a',
        currencyInDecimals: 2,
      )
    ];
    final List<CurrencyItem> currencyItem = currencyItemModelList;

    when(mockCurrencyConverterDatasource.getCurrencyList()).thenAnswer(
        (realInvocation) => Future.value(Right(currencyItemModelList)));

    var result = await currencyConverterRepositoryimpl.getProductCurrencyList();

    expect(result, Right(currencyItem));

    verify(mockCurrencyConverterDatasource.getCurrencyList());
    verifyNoMoreInteractions(mockCurrencyConverterDatasource);
  });

  test('should get CurrencyRate from EasyResendtDataSource', () async {
    final currencyRateModel = CurrencyRateModel(rate: 1.0);
    final CurrencyRate currencyRate = currencyRateModel;

    final requestModel = CurrencyRateRequestModel(fcCode: 'A', lcCode: 'A');
    final CurrencyRateRequest request = requestModel;

    when(mockCurrencyConverterDatasource.getCurrencyRate(requestModel))
        .thenAnswer((realInvocation) => Future.value(Right(currencyRateModel)));

    var result = await currencyConverterRepositoryimpl.getCurrencyRate(request);

    expect(result, Right(currencyRate));

    verify(mockCurrencyConverterDatasource.getCurrencyRate(requestModel));
    verifyNoMoreInteractions(mockCurrencyConverterDatasource);
  });

  test('should get list of CurrencyRateTrend from CurrencyConverterDatasource',
      () async {
    final currencyRateTrendModelList = [
      CurrencyRateTrendModel(
        trendPeriodTitle: 'A',
        trendItemList: [
          CurrencyRateTrendItemModel(
              currencyRate: 1.0, dateTime: '2021-11-11T11:11:11')
        ],
      ),
    ];
    final List<CurrencyRateTrend> currencyRateTrendList =
        currencyRateTrendModelList;

    final currencyRateTrendRequestModel =
        CurrencyRateTrendRequestModel(fcCode: 'A', lcCode: 'A');
    final CurrencyRateTrendRequest currencyRateTrendRequest =
        currencyRateTrendRequestModel;

    when(mockCurrencyConverterDatasource
            .getCurrencyTrendChartValues(currencyRateTrendRequestModel))
        .thenAnswer((realInvocation) =>
            Future.value(Right(currencyRateTrendModelList)));

    var result = await currencyConverterRepositoryimpl
        .getCurrencyRateTrendChartValues(currencyRateTrendRequest);

    expect(result, Right(currencyRateTrendList));

    verify(mockCurrencyConverterDatasource
        .getCurrencyTrendChartValues(currencyRateTrendRequestModel));
    verifyNoMoreInteractions(mockCurrencyConverterDatasource);
  });
}
