import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_details_request.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item_details_.dart';
import 'package:domain/feature/transaction_history/usecases/get_pending_transaction_details.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';

import 'get_pending_transaction_details_test.mocks.dart';

@GenerateMocks([TransactionHistoryRepository])
main() {
  late GetPendingTransactionDetails getPendingTransactionDetails;

  late MockTransactionHistoryRepository mockTransactionHistoryRepository;

  setUp(() {
    mockTransactionHistoryRepository = MockTransactionHistoryRepository();
    getPendingTransactionDetails =
        GetPendingTransactionDetails(mockTransactionHistoryRepository);
  });

  test(
      'should call method getPendingTransactionItemDetails on TransactionHistoryRepository with provided referenceId',
      () async {
    final referenceId = 12334;

    PendingTransactionDetailsRequest req =
        PendingTransactionDetailsRequest(referenceId: referenceId);

    final item = PendingTransactionItemDetails(
      accountNumber: '',
      agentName: '',
      beneNickName: '',
      beneficiaryName: '',
      dateTimeOfTransaction: '2012-02-27 13:27:00.123456789z',
      fcCurrecny: '',
      fundReceived: 1,
      fundSent: 1,
      lcCurrency: '',
      paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
      refrenceId: 1,
      transactionStatus: TransactionStatus(code: 1, title: 'In process'),
      transactionTimeoutInMinutes: 1,
    );

    when(mockTransactionHistoryRepository.getPendingTransactionItemDetails(req))
        .thenAnswer((realInvocation) => Future.value(Right(item)));

    final result = await getPendingTransactionDetails(
        GetPendingTransactionDetailsParams(referenceId));
    expect(result, Right(item));

    verify(
        mockTransactionHistoryRepository.getPendingTransactionItemDetails(req));
  });
}
