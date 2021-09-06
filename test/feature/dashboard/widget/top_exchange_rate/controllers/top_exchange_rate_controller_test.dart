import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/entity/top_exchange_rate_item.dart';
import 'package:domain/feature/dashboard/top_exchange_rate/usecases/get_top_exchange_rate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/feature/dashboard/widget/top_exchange_rate/controllers/top_exchange_rate_controller.dart';

import 'top_exchange_rate_controller_test.mocks.dart';

@GenerateMocks([GetTopExchangeRate])
main() {
  late MockGetTopExchangeRate mockGetTopExchangeRate;
  late TopExchangeRateController topExchangeRateController;

  setUp(() {
    mockGetTopExchangeRate = MockGetTopExchangeRate();
    topExchangeRateController =
        TopExchangeRateController(mockGetTopExchangeRate);
  });

  test(
      'should call GetTopExchangeRate usecase when initGetTopExchangeRate called',
      () {
    final params = GetTopExchangeRateParams();

    when(mockGetTopExchangeRate(params)).thenAnswer((realInvocation) =>
        Future.value(
            Right(TopExchangeRateItem(currencyCode: '', currencyRate: 1))));

    topExchangeRateController.initGetTopExchangeRate();

    verify(mockGetTopExchangeRate(params));
  });
}
