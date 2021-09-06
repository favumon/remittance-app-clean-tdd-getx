import 'package:domain/feature/transaction_history/entities/complete_transaction_request.dart';
import 'package:domain/feature/transaction_history/usecases/complete_transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';

import 'complete_transaction_test.mocks.dart';

@GenerateMocks([TransactionHistoryRepository])
main() {
  late CompleteTransaction completeTransaction;

  late MockTransactionHistoryRepository mockTransactionHistoryRepository;

  setUp(() {
    mockTransactionHistoryRepository = MockTransactionHistoryRepository();
    completeTransaction = CompleteTransaction(mockTransactionHistoryRepository);
  });

  test(
      'should call method confirmPendingTransaction on TransactionHistoryRepository with provided referenceId',
      () async {
    final referenceId = 12334;
    final txnRefNo = 1;
    final docPath = '';

    CompleteTransactionRequest req = CompleteTransactionRequest(
        transRefId: referenceId,
        pendingTxnBankRefNo: txnRefNo,
        referenceDocPath: docPath);

    when(mockTransactionHistoryRepository.confirmPendingTransaction(req))
        .thenAnswer(
            (realInvocation) => Future.value(Right(CommonApiResponse())));

    final result = await completeTransaction(CompleteTransactionParams(
      transactionRefId: referenceId,
      pendingTxnBankRefNo: txnRefNo,
      referenceDocPath: docPath,
    ));
    expect(result, Right(CommonApiResponse()));

    verify(mockTransactionHistoryRepository.confirmPendingTransaction(req));
  });
}
