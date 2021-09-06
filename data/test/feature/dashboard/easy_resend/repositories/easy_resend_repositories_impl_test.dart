import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/easy_resend/model/easy_resend_request_model.dart';
import 'package:data/feature/dashboard/easy_resend/repositories/easy_resend_repositories_impl.dart';
import 'package:data/feature/dashboard/easy_resend/data_sources/easy_resend_data_source.dart';
import 'package:data/feature/dashboard/easy_resend/model/easy_resend_item_model.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_item.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_request.dart';

import 'easy_resend_repositories_impl_test.mocks.dart';

@GenerateMocks([EasyResendtDataSource])
main() {
  late MockEasyResendtDataSource mockEasyResendtDataSource;

  late EasyResendRepositoriesImpl easyResendRepositoriesImpl;

  setUp(() {
    mockEasyResendtDataSource = MockEasyResendtDataSource();
    easyResendRepositoriesImpl =
        EasyResendRepositoriesImpl(mockEasyResendtDataSource);
  });

  test('should get list of EasyResendItem from EasyResendtDataSource',
      () async {
    final easyResendItemModelList = [
      EasyResendItemModel(
        beneficiaryName: 'A',
        transactionRefNumber: 1,
        transactionDate: '2021-11-11T11:11:11.000',
        beneficiaryCurrencyAmount: 1,
        beneficiaryCurrencyCode: 'INR',
      )
    ];
    final List<EasyResendItem> easyResend = easyResendItemModelList;

    final requestModel = EasyResendRequestModel();
    final EasyResendRequest request = requestModel;

    when(mockEasyResendtDataSource.getEasyResend(requestModel)).thenAnswer(
        (realInvocation) => Future.value(Right(easyResendItemModelList)));

    var result = await easyResendRepositoriesImpl.getEasyResend(request);

    expect(result, Right(easyResend));

    verify(mockEasyResendtDataSource.getEasyResend(requestModel));
    verifyNoMoreInteractions(mockEasyResendtDataSource);
  });
}
