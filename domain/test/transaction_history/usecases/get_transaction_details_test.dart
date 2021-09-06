import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/transaction_history/entities/transaction_details_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_request.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_details.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';

import 'get_pending_transaction_details_test.mocks.dart';

@GenerateMocks([TransactionHistoryRepository])
main() {
  late GetTransactionDetails getTransactionDetails;

  late MockTransactionHistoryRepository mockTransactionHistoryRepository;

  setUp(() {
    mockTransactionHistoryRepository = MockTransactionHistoryRepository();
    getTransactionDetails =
        GetTransactionDetails(mockTransactionHistoryRepository);
  });

  test(
      'should call method getTransactionItemDetails on TransactionHistoryRepository with provided referenceId',
      () async {
    final referenceId = 12334;

    TransactionDetailsRequest req =
        TransactionDetailsRequest(referenceId: referenceId);

    final item = TransactionDetailsItem(
        accountNumber: '',
        agentName: '',
        beneficiaryName: '',
        branchName: '',
        cityName: '',
        countryName: '',
        dateTimeOfTransaction: '2012-02-27 13:27:00.123456789z',
        fcCurrency: '',
        fundReceived: 1,
        fundSent: 1,
        lcCurrency: '',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        refrenceId: 1,
        swiftCode: '',
        transactionStatus: TransactionStatus(code: 1, title: 'Successful'));

    when(mockTransactionHistoryRepository.getTransactionItemDetails(req))
        .thenAnswer((realInvocation) => Future.value(Right(item)));

    final result =
        await getTransactionDetails(GetTransactionDetailsParams(referenceId));
    expect(result, Right(item));

    verify(mockTransactionHistoryRepository.getTransactionItemDetails(req));
  });
}
