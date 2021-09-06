import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item_details_.dart';
import 'package:domain/feature/transaction_history/entities/reference_image.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:domain/feature/transaction_history/usecases/cancel_transaction.dart';
import 'package:domain/feature/transaction_history/usecases/complete_transaction.dart';
import 'package:domain/feature/transaction_history/usecases/get_pending_transaction_details.dart';
import 'package:domain/feature/transaction_history/usecases/pick_reference_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/transaction_history/controllers/pending_transaction_item_details_page_controller.dart';

import 'pending_transaction_item_details_page_controller_test.mocks.dart';

@GenerateMocks([
  AlertService,
  NavigationService,
  GetPendingTransactionDetails,
  CancelTransaction,
  CompleteTransaction,
  PickReferenceImage
])
main() {
  late MockAlertService mockAlertService;
  late MockNavigationService mockNavigationService;
  late MockGetPendingTransactionDetails mockGetPendingTransactionDetails;
  late MockCancelTransaction mockCancelTransaction;
  late MockCompleteTransaction mockCompleteTransaction;
  late MockPickReferenceImage mockPickReferenceImage;
  late PendingTrasactionItemDetailsPageController
      pendingTrasactionItemDetailsPageController;

  setUp(() {
    mockAlertService = MockAlertService();
    mockNavigationService = MockNavigationService();
    mockGetPendingTransactionDetails = MockGetPendingTransactionDetails();
    mockCancelTransaction = MockCancelTransaction();
    mockCompleteTransaction = MockCompleteTransaction();
    mockPickReferenceImage = MockPickReferenceImage();

    pendingTrasactionItemDetailsPageController =
        PendingTrasactionItemDetailsPageController(
            mockAlertService,
            mockNavigationService,
            mockGetPendingTransactionDetails,
            mockCancelTransaction,
            mockCompleteTransaction,
            mockPickReferenceImage);
  });

  test(
      'should call GetPendingTransactionHistoryList with GetPendingTransactionDetailsParams',
      () async {
    GetPendingTransactionDetailsParams params =
        GetPendingTransactionDetailsParams(1);

    PendingTransactionItemDetails res = PendingTransactionItemDetails(
        transactionStatus: TransactionStatus(code: 1, title: 'In process'),
        accountNumber: '12',
        agentName: '',
        beneNickName: '',
        beneficiaryName: '',
        dateTimeOfTransaction: '2012-02-28T14:50:00.000',
        fcCurrecny: '',
        fundReceived: 1,
        fundSent: 1,
        lcCurrency: '',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        refrenceId: 1,
        transactionTimeoutInMinutes: 1);

    when(mockGetPendingTransactionDetails(params))
        .thenAnswer((realInvocation) => Future.value(Right(res)));

    await pendingTrasactionItemDetailsPageController
        .getPendingTransactionDetails(1);

    verify(mockGetPendingTransactionDetails(params));
  });

  test('should call CancelTransaction with CancelTransactionParams', () async {
    CancelTransactionParams params = CancelTransactionParams(
        reasonForCancelleation: '', transactionRefId: 1);
    CommonApiResponse response = CommonApiResponse();

    PendingTransactionItemDetails res = PendingTransactionItemDetails(
        transactionStatus: TransactionStatus(code: 1, title: 'In process'),
        accountNumber: '12',
        agentName: 'A',
        beneNickName: 'A',
        beneficiaryName: 'A',
        dateTimeOfTransaction: '2012-02-28T14:50:00.000',
        fcCurrecny: 'A',
        fundReceived: 1,
        fundSent: 1,
        lcCurrency: 'A',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        refrenceId: 1,
        transactionTimeoutInMinutes: 1);

    pendingTrasactionItemDetailsPageController.pendingTransactionItemDetails =
        res;

    when(mockCancelTransaction(params))
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    await pendingTrasactionItemDetailsPageController.cancel();

    verify(mockCancelTransaction(params));
  });

  test(
      'should navigate to transactionCalledPage when CancelTransaction return a CommonApiResponse',
      () async {
    CommonApiResponse response = CommonApiResponse();

    PendingTransactionItemDetails res = PendingTransactionItemDetails(
        transactionStatus: TransactionStatus(code: 1, title: 'In process'),
        accountNumber: '12',
        agentName: '',
        beneNickName: '',
        beneficiaryName: '',
        dateTimeOfTransaction: '2012-02-28T14:50:00.000',
        fcCurrecny: '',
        fundReceived: 1,
        fundSent: 1,
        lcCurrency: '',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        refrenceId: 1,
        transactionTimeoutInMinutes: 1);

    pendingTrasactionItemDetailsPageController.pendingTransactionItemDetails =
        res;

    when(mockCancelTransaction(any))
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    await pendingTrasactionItemDetailsPageController.cancel();

    verify(mockCancelTransaction(any));
    verify(mockNavigationService.navigateAndReplace(
        AppRouts.transactionCancelledPage,
        arguments: pendingTrasactionItemDetailsPageController
            .pendingTransactionItemDetails,
        result: true));
  });

  test('should call CompleteTransaction with CompleteTransactionParams',
      () async {
    CompleteTransactionParams params = CompleteTransactionParams(
      transactionRefId: 1,
      pendingTxnBankRefNo: 1,
      referenceDocPath: '',
    );
    CommonApiResponse response = CommonApiResponse();

    PendingTransactionItemDetails res = PendingTransactionItemDetails(
        transactionStatus: TransactionStatus(code: 1, title: 'In process'),
        accountNumber: '12',
        agentName: '',
        beneNickName: '',
        beneficiaryName: '',
        dateTimeOfTransaction: '2012-02-28T14:50:00.000',
        fcCurrecny: '',
        fundReceived: 1,
        fundSent: 1,
        lcCurrency: '',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        refrenceId: 1,
        transactionTimeoutInMinutes: 1);

    pendingTrasactionItemDetailsPageController.pendingTransactionItemDetails =
        res;

    when(mockCompleteTransaction(params))
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    await pendingTrasactionItemDetailsPageController
        .completeTransaction(params);

    verify(mockCompleteTransaction(params));
  });

  test(
      'should navigate to transactionCompletedPage when CompleteTransaction return a commonApiResponse',
      () async {
    CommonApiResponse response = CommonApiResponse();

    var params = CompleteTransactionParams(
      transactionRefId: 1,
      pendingTxnBankRefNo: 1,
      referenceDocPath: "",
    );

    PendingTransactionItemDetails res = PendingTransactionItemDetails(
        transactionStatus: TransactionStatus(code: 1, title: 'In process'),
        accountNumber: '12',
        agentName: '',
        beneNickName: '',
        beneficiaryName: '',
        dateTimeOfTransaction: '2012-02-28T14:50:00.000',
        fcCurrecny: '',
        fundReceived: 1,
        fundSent: 1,
        lcCurrency: '',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        refrenceId: 1,
        transactionTimeoutInMinutes: 1);

    pendingTrasactionItemDetailsPageController.pendingTransactionItemDetails =
        res;

    when(mockCompleteTransaction(any))
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    await pendingTrasactionItemDetailsPageController
        .completeTransaction(params);

    verify(mockCompleteTransaction(any));
    verify(mockNavigationService
        .navigateAndReplace(AppRouts.transactionCompletedPage, result: true));
  });

  test('should call PickReferenceImage', () async {
    ReferenceImage referenceImage =
        ReferenceImage(imageName: '', imagePath: '');
    NoParams params = NoParams();

    when(mockPickReferenceImage(params))
        .thenAnswer((realInvocation) => Future.value(Right(referenceImage)));

    await pendingTrasactionItemDetailsPageController.selectReferenceImage();

    verify(mockPickReferenceImage(params));
  });
}
