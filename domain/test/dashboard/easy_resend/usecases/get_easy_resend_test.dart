import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_request.dart';
import 'package:domain/feature/dashboard/easy_resend/usecases/get_easy_resend.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_item.dart';
import 'package:domain/feature/dashboard/easy_resend/repositories/easy_resend_repository.dart';

import 'get_easy_resend_test.mocks.dart';

@GenerateMocks([EasyResendRepository])
main() {
  late MockEasyResendRepository mockEasyResendRepository;
  late GetEasyResend getEasyResend;

  setUp(() {
    mockEasyResendRepository = MockEasyResendRepository();
    getEasyResend = GetEasyResend(mockEasyResendRepository);
  });

  test('Should get List of EasyResendItem from EasyResendRepository', () async {
    final listdata = [
      EasyResendItem(
        beneficiaryCurrencyAmount: 1,
        beneficiaryCurrencyCode: '',
        beneficiaryName: '',
        transactionDate: '',
        transactionRefNumber: 1,
      )
    ];
    final params = GetEasyResendParams();
    final request = EasyResendRequest();

    when(mockEasyResendRepository.getEasyResend(request))
        .thenAnswer((realInvocation) => Future.value(Right(listdata)));

    var result = await getEasyResend(params);

    expect(result, Right(listdata));
  });
}
