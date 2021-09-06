import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/top_exchange_rate/data_sources/top_exchange_rate_data_source.dart';
import 'package:data/feature/dashboard/top_exchange_rate/model/top_exchange_rate_item_model.dart';
import 'package:data/feature/dashboard/top_exchange_rate/model/top_exchange_rate_request_model.dart';
import 'package:data/feature/dashboard/top_exchange_rate/repositories/top_exchange_rate_repositories_impl.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_item.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_request.dart';

import 'top_exchange_rate_repositories_impl_test.mocks.dart';

@GenerateMocks([TopExchangeRateDataSource])
main() {
  late MockTopExchangeRateDataSource mockTopExchangeRateDataSource;
  late TopExchangeRateRepositoriesImpl topExchangeRateRepositoriesImpl;

  setUp(() {
    mockTopExchangeRateDataSource = MockTopExchangeRateDataSource();
    topExchangeRateRepositoriesImpl =
        TopExchangeRateRepositoriesImpl(mockTopExchangeRateDataSource);
  });

  test('should get TopExchangeRateItem from TopExchangeRateDataSource',
      () async {
    final requestModel = TopExchangeRateRequestModel();
    final TopExchangeRateRequest request = requestModel;

    final itemModel =
        TopExchangeRateModel(currencyRate: 1, currencyCode: 'INR');
    final TopExchangeRateItem item = itemModel;

    when(mockTopExchangeRateDataSource.getTopExchangeRate(requestModel))
        .thenAnswer((realInvocation) => Future.value(Right(itemModel)));

    var result =
        await topExchangeRateRepositoriesImpl.getTopExchangeRate(request);

    expect(result, Right(item));

    verify(mockTopExchangeRateDataSource.getTopExchangeRate(requestModel));
    verifyNoMoreInteractions(mockTopExchangeRateDataSource);
  });
}
