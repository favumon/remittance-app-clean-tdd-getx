import 'package:dartz/dartz.dart';
import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:domain/feature/transaction_history/usecases/get_transaction_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/transaction_history/controllers/recent_transaction_item_details_page_controller.dart';

import 'recent_transaction_item_details_page_controller_test.mocks.dart';

@GenerateMocks([
  AlertService,
  NavigationService,
  GetTransactionDetails,
])
main() {
  late MockAlertService mockAlertService;
  late MockNavigationService mockNavigationService;
  late MockGetTransactionDetails mockGetTransactionDetails;
  late RecentTrasactionItemDetailsPageController
      recentTrasactionItemDetailsPageController;

  setUp(() {
    mockAlertService = MockAlertService();
    mockNavigationService = MockNavigationService();
    mockGetTransactionDetails = MockGetTransactionDetails();

    recentTrasactionItemDetailsPageController =
        RecentTrasactionItemDetailsPageController(
      mockAlertService,
      mockNavigationService,
      mockGetTransactionDetails,
    );
  });

  test(
      'should call GetPendingTransactionHistoryList with GetPendingTransactionDetailsParams',
      () async {
    GetTransactionDetailsParams params = GetTransactionDetailsParams(1);

    TransactionDetailsItem res = TransactionDetailsItem(
        transactionStatus: TransactionStatus(code: 1, title: 'In process'),
        accountNumber: '12',
        agentName: '',
        beneficiaryName: '',
        dateTimeOfTransaction: '',
        fcCurrency: '',
        fundReceived: 1,
        fundSent: 1,
        lcCurrency: '',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        refrenceId: 1,
        branchName: '',
        cityName: '',
        countryName: '',
        swiftCode: '');

    when(mockGetTransactionDetails(params))
        .thenAnswer((realInvocation) => Future.value(Right(res)));

    await recentTrasactionItemDetailsPageController.getTransactionDetails(1);

    verify(mockGetTransactionDetails(params));
  });
}
