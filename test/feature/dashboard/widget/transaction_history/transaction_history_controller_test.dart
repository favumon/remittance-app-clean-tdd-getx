import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_item.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/usecases/get_pending_transaction_count.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/dashboard/widget/transaction_history/transaction_history_controller.dart';

import 'transaction_history_controller_test.mocks.dart';

@GenerateMocks([NavigationService, GetPendingTransactionCount])
main() {
  late MockNavigationService mockNavigationService;
  late MockGetPendingTransactionCount mockGetPendingTransactionCount;
  late TransactionHistoryContainerController
      transactionHistoryContainerController;

  setUp(() {
    mockNavigationService = MockNavigationService();
    mockGetPendingTransactionCount = MockGetPendingTransactionCount();
    transactionHistoryContainerController =
        TransactionHistoryContainerController(
            mockGetPendingTransactionCount, mockNavigationService);
  });

  test(
      'should call GetPendingTransactionCount usecase when initGetPendingTransactionCountCount called',
      () async {
    final params = GetPendingTransactionCountParams();

    final request = PendingTransactionCountItem(pendingTransactionCount: 1);

    when(mockGetPendingTransactionCount(params))
        .thenAnswer((realInvocation) => Future.value(Right(request)));

    transactionHistoryContainerController.initGetPendingTransactionCountCount();

    verify(mockGetPendingTransactionCount(params));
  });
}
