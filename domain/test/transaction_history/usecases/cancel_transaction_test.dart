import 'package:domain/feature/transaction_history/entities/cancel_transaction_request.dart';
import 'package:domain/feature/transaction_history/usecases/cancel_transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';

import 'cancel_transaction_test.mocks.dart';

@GenerateMocks([TransactionHistoryRepository])
main() {
  late CancelTransaction cancelTransaction;

  late MockTransactionHistoryRepository mockTransactionHistoryRepository;

  setUp(() {
    mockTransactionHistoryRepository = MockTransactionHistoryRepository();
    cancelTransaction = CancelTransaction(mockTransactionHistoryRepository);
  });

  test(
      'should call method cancelPendingTransaction on TransactionHistoryRepository with provided referenceId',
      () async {
    final referenceId = 12334;
    final reason = '';

    CancelTransactionRequest req =
        CancelTransactionRequest(transRefId: referenceId, reason: reason);

    when(mockTransactionHistoryRepository.cancelPendingTransaction(req))
        .thenAnswer(
            (realInvocation) => Future.value(Right(CommonApiResponse())));

    final result = await cancelTransaction(CancelTransactionParams(
        reasonForCancelleation: reason, transactionRefId: referenceId));
    expect(result, Right(CommonApiResponse()));

    verify(mockTransactionHistoryRepository.cancelPendingTransaction(req));
  });
}
