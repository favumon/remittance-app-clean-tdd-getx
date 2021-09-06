import 'package:domain/core/utils/helper_functions.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_list_request.dart';
import 'package:domain/feature/transaction_history/usecases/get_pending_transaction_history_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';

import 'get_pending_transaction_history_list_test.mocks.dart';

@GenerateMocks([TransactionHistoryRepository])
main() {
  late GetPendingTransactionHistoryList getPendingTransactionHistoryList;

  late MockTransactionHistoryRepository mockTransactionHistoryRepository;

  setUp(() {
    mockTransactionHistoryRepository = MockTransactionHistoryRepository();
    getPendingTransactionHistoryList =
        GetPendingTransactionHistoryList(mockTransactionHistoryRepository);
  });

  test(
      'should call method getPendingTransactionsList on TransactionHistoryRepository with filter list',
      () async {
    final filterList = <int>[];
    final pendingTransactionsList = <PendingTransactionItem>[];

    PendingTransactionListRequest req =
        PendingTransactionListRequest(paymentModeFilterList: filterList);

    when(mockTransactionHistoryRepository.getPendingTransactionsList(req))
        .thenAnswer(
            (realInvocation) => Future.value(Right(pendingTransactionsList)));

    final result = await getPendingTransactionHistoryList(
        GetPendingTransactionHistoryListParams(filterList));
    expect(result, Right(pendingTransactionsList));

    verify(mockTransactionHistoryRepository.getPendingTransactionsList(req));
  });
}
