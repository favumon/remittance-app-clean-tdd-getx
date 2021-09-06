import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/transaction_history/usecases/get_pending_transaction_history_list.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_payment_mode_filters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/transaction_history/controllers/pending_transaction_history_list_page_controller.dart';

import 'pending_transaction_history_list_page_controller_test.mocks.dart';

@GenerateMocks([
  AlertService,
  NavigationService,
  GetPendingTransactionHistoryList,
  GetTransactionPaymentModeFilters
])
main() {
  late MockAlertService mockAlertService;
  late MockNavigationService mockNavigationService;
  late MockGetPendingTransactionHistoryList
      mockGetPendingTransactionHistoryList;
  late PendingTrasactionHistoryListPageController
      pendingTrasactionHistoryListPageController;
  late MockGetTransactionPaymentModeFilters
      mockGetTransactionPaymentModeFilters;

  setUp(() {
    mockAlertService = MockAlertService();
    mockNavigationService = MockNavigationService();
    mockGetPendingTransactionHistoryList =
        MockGetPendingTransactionHistoryList();
    mockGetTransactionPaymentModeFilters =
        MockGetTransactionPaymentModeFilters();

    pendingTrasactionHistoryListPageController =
        PendingTrasactionHistoryListPageController(
      mockAlertService,
      mockNavigationService,
      mockGetPendingTransactionHistoryList,
      mockGetTransactionPaymentModeFilters,
    );
  });

  test('should call GetPendingTransactionHistoryList', () async {
    when(mockGetPendingTransactionHistoryList(
            GetPendingTransactionHistoryListParams([])))
        .thenAnswer((realInvocation) => Future.value(Right([])));

    await pendingTrasactionHistoryListPageController
        .getPendingTransactionHistory([]);

    verify(mockGetPendingTransactionHistoryList(
        GetPendingTransactionHistoryListParams([])));
  });

  test('should call GetTransactionPaymentModeFilters when getFilterList called',
      () async {
    when(mockGetTransactionPaymentModeFilters(NoParams()))
        .thenAnswer((realInvocation) => Future.value(Right([])));

    await pendingTrasactionHistoryListPageController.getFilterList();

    verify(mockGetTransactionPaymentModeFilters(NoParams()));
  });
}
