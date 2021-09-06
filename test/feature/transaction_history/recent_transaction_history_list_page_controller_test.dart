import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_history_list.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_payment_mode_filters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/transaction_history/controllers/recent_transaction_history_list_page_controller.dart';

import 'recent_transaction_history_list_page_controller_test.mocks.dart';

@GenerateMocks([
  AlertService,
  NavigationService,
  GetTransactionHistoryList,
  GetTransactionPaymentModeFilters
])
main() {
  late MockAlertService mockAlertService;
  late MockNavigationService mockNavigationService;
  late MockGetTransactionHistoryList mockGetTransactionHistoryList;
  late RecentTrasactionHistoryListPageController
      recentTrasactionHistoryListPageController;
  late MockGetTransactionPaymentModeFilters
      mockGetTransactionPaymentModeFilters;

  setUp(() {
    mockAlertService = MockAlertService();
    mockNavigationService = MockNavigationService();
    mockGetTransactionHistoryList = MockGetTransactionHistoryList();
    mockGetTransactionPaymentModeFilters =
        MockGetTransactionPaymentModeFilters();

    recentTrasactionHistoryListPageController =
        RecentTrasactionHistoryListPageController(
      mockAlertService,
      mockNavigationService,
      mockGetTransactionHistoryList,
      mockGetTransactionPaymentModeFilters,
    );
  });

  test('should call  when GetTransactionHistoryList', () async {
    GetTransactionHistoryListParams params =
        GetTransactionHistoryListParams([]);

    when(mockGetTransactionHistoryList(params))
        .thenAnswer((realInvocation) => Future.value(Right([])));

    await recentTrasactionHistoryListPageController.getTransactionHistory([]);

    verify(mockGetTransactionHistoryList(params));
  });

  test('should call GetTransactionPaymentModeFilters when getFilterList called',
      () async {
    when(mockGetTransactionPaymentModeFilters(NoParams()))
        .thenAnswer((realInvocation) => Future.value(Right([])));

    await recentTrasactionHistoryListPageController.getFilterList();

    verify(mockGetTransactionPaymentModeFilters(NoParams()));
  });
}
