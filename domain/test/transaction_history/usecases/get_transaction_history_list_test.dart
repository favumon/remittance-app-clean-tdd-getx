import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/transaction_history/entities/transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_list_request.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_history_list.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';

import 'get_transaction_history_list_test.mocks.dart';

@GenerateMocks([TransactionHistoryRepository])
main() {
  late GetTransactionHistoryList getTransactionHistoryList;

  late MockTransactionHistoryRepository mockTransactionHistoryRepository;

  setUp(() {
    mockTransactionHistoryRepository = MockTransactionHistoryRepository();
    getTransactionHistoryList =
        GetTransactionHistoryList(mockTransactionHistoryRepository);
  });

  test(
      'should call method getTransactionsList on TransactionHistoryRepository with filter list',
      () async {
    final filterList = <int>[];
    final transactionsList = <TransactionItem>[];

    TransactionListRequest req =
        TransactionListRequest(paymentModeFilterList: filterList);

    when(mockTransactionHistoryRepository.getTransactionsList(req))
        .thenAnswer((realInvocation) => Future.value(Right(transactionsList)));

    final result = await getTransactionHistoryList(
        GetTransactionHistoryListParams(filterList));
    expect(result, Right(transactionsList));

    verify(mockTransactionHistoryRepository.getTransactionsList(req));
  });
}
