import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_item.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_request.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/repositories/top_exchange_rate_repository.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/usecases/get_top_exchange_rate.dart';

import 'get_top_exchange_rate_test.mocks.dart';

@GenerateMocks([TopExchangeRateRepository])
main() {
  late MockTopExchangeRateRepository mockTopExchangeRateRepository;
  late GetTopExchangeRate getTopExchangeRate;

  setUp(() {
    mockTopExchangeRateRepository = MockTopExchangeRateRepository();
    getTopExchangeRate = GetTopExchangeRate(mockTopExchangeRateRepository);
  });

  test('should get TopExchangeRateItem from TopExchangeRateRepository',
      () async {
    final params = GetTopExchangeRateParams();
    final request = TopExchangeRateRequest();
    final response = TopExchangeRateItem(currencyCode: '', currencyRate: 1);

    when(mockTopExchangeRateRepository.getTopExchangeRate(request))
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    var result = await getTopExchangeRate(params);

    verify(mockTopExchangeRateRepository.getTopExchangeRate(request));

    expect(result, Right(response));
  });
}
