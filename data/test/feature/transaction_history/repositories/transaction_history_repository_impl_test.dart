import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:data/feature/transaction_history/models/transaction_payment_mode_filter_model.dart';
import 'package:data/feature/transaction_history/models/payment_mode_model.dart';
import 'package:data/feature/transaction_history/models/transaction_status_model.dart';
import 'package:data/core/models/common_api_response_model.dart';
import 'package:data/feature/transaction_history/datasources/transaction_history_datasource.dart';
import 'package:data/feature/transaction_history/models/cancel_transaction_request_model.dart';
import 'package:data/feature/transaction_history/models/complete_transaction_request_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_details_request_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_item_details_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_item_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_list_request_model.dart';
import 'package:data/feature/transaction_history/models/transaction_detail_request_model.dart';
import 'package:data/feature/transaction_history/models/transaction_details_item_model.dart';
import 'package:data/feature/transaction_history/models/transaction_item_model.dart';
import 'package:data/feature/transaction_history/models/transaction_list_request_model.dart';
import 'package:data/feature/transaction_history/repositories/transaction_history_repository_impl.dart';

import 'transaction_history_repository_impl_test.mocks.dart';

@GenerateMocks([TransactionHistoryDataSource])
main() {
  late MockTransactionHistoryDataSource mockTransactionHistoryDataSource;
  late TransactionHistoryRepositoryImpl transactionHistoryRepositoryImpl;

  setUp(() {
    mockTransactionHistoryDataSource = MockTransactionHistoryDataSource();
    transactionHistoryRepositoryImpl =
        TransactionHistoryRepositoryImpl(mockTransactionHistoryDataSource);
  });

  test(
      'should call requestPendingTransactionDetails on TransactionHistoryDataSource with PendingTransactionDetailsRequestModel params',
      () async {
    final referenceId = 1;
    final pendingTransactionDetailsRequestModel =
        PendingTransactionDetailsRequestModel(referenceId);

    final pendingTransactionItemDetailsModel =
        PendingTransactionItemDetailsModel(
      accountNumber: '98765456789',
      agentName: 'Axis Bank',
      beneNickName: 'Mar',
      dateTimeOfTransaction: '2012-02-27T13:27:00.000',
      fcCurrency: 'INR',
      fundReceived: 1273654.09,
      fundSent: 1200.9,
      refrenceId: 12345676543,
      transactionTimeoutInMinutes: 120,
      paymentMode: PaymentModeModel(code: 13, title: 'Bank Transfer'),
      beneficiaryName: 'Maria K K',
      transactionStatus: TransactionStatusModel(code: 0, title: 'In process'),
      lcCurrency: 'QAD',
    );

    when(mockTransactionHistoryDataSource.requestPendingTransactionDetails(
            pendingTransactionDetailsRequestModel))
        .thenAnswer((realInvocation) =>
            Future.value(Right(pendingTransactionItemDetailsModel)));

    await transactionHistoryRepositoryImpl.getPendingTransactionItemDetails(
        pendingTransactionDetailsRequestModel);

    verify(mockTransactionHistoryDataSource.requestPendingTransactionDetails(
        pendingTransactionDetailsRequestModel));

    verifyNoMoreInteractions(mockTransactionHistoryDataSource);
  });

  test(
      'should call requestTransactionDetails on TransactionHistoryDataSource with TransactionDetailsRequestModel params',
      () async {
    final referenceId = 1;
    final transactionDetailsRequestModel =
        TransactionDetailsRequestModel(refrenceId: referenceId);

    final transactionDetailsItemModel = TransactionDetailsItemModel(
      accountNumber: '9876545678',
      agentName: 'SBI Bank',
      dateTimeOfTransaction: '2012-02-27T13:27:00.000',
      fcCurrency: 'INR',
      fundReceived: 1273654.09,
      fundSent: 1200.9,
      refrenceId: 8765456789,
      paymentMode: PaymentModeModel(code: 13, title: "Bank Transfer"),
      beneficiaryName: 'Maria K K',
      transactionStatus: TransactionStatusModel(code: 1, title: 'Successful'),
      lcCurrency: 'QAD',
      branchName: 'Ernakulam',
      cityName: 'Kochi',
      countryName: 'India',
      swiftCode: 'UVTN00291928',
    );

    when(mockTransactionHistoryDataSource
            .requestTransactionDetails(transactionDetailsRequestModel))
        .thenAnswer((realInvocation) =>
            Future.value(Right(transactionDetailsItemModel)));

    await transactionHistoryRepositoryImpl
        .getTransactionItemDetails(transactionDetailsRequestModel);

    verify(mockTransactionHistoryDataSource
        .requestTransactionDetails(transactionDetailsRequestModel));

    verifyNoMoreInteractions(mockTransactionHistoryDataSource);
  });

  test(
      'should call requestPendingTransactionHistory on TransactionHistoryDataSource with PendingTransactionListRequestModel params',
      () async {
    final filterList = <int>[];

    final pendingTransactionListRequestModel =
        PendingTransactionListRequestModel(filterList);

    final pendingTransactionItemModelList = <PendingTransactionItemModel>[];

    when(mockTransactionHistoryDataSource.requestPendingTransactionHistory(
            pendingTransactionListRequestModel))
        .thenAnswer((realInvocation) =>
            Future.value(Right(pendingTransactionItemModelList)));

    await transactionHistoryRepositoryImpl
        .getPendingTransactionsList(pendingTransactionListRequestModel);

    verify(mockTransactionHistoryDataSource
        .requestPendingTransactionHistory(pendingTransactionListRequestModel));

    verifyNoMoreInteractions(mockTransactionHistoryDataSource);
  });

  test(
      'should call requestTransactionHistory on TransactionHistoryDataSource with TransactionListRequestModel params',
      () async {
    final filterList = <int>[];

    final transactionListRequestModel = TransactionListRequestModel(filterList);

    final transactionItemModel = <TransactionItemModel>[];

    when(mockTransactionHistoryDataSource
            .requestTransactionHistory(transactionListRequestModel))
        .thenAnswer(
            (realInvocation) => Future.value(Right(transactionItemModel)));

    await transactionHistoryRepositoryImpl
        .getTransactionsList(transactionListRequestModel);

    verify(mockTransactionHistoryDataSource
        .requestTransactionHistory(transactionListRequestModel));

    verifyNoMoreInteractions(mockTransactionHistoryDataSource);
  });

  test(
      'should call cancelPendingTransaction on TransactionHistoryDataSource with CommonApiResponseModel params',
      () async {
    final referenceId = 1;
    final reason = '';

    final cancelTransactionRequestModel =
        CancelTransactionRequestModel(referenceId, reason);

    final commonApiResponseModel = CommonApiResponseModel();

    when(mockTransactionHistoryDataSource
            .cancelPendingTransaction(cancelTransactionRequestModel))
        .thenAnswer(
            (realInvocation) => Future.value(Right(commonApiResponseModel)));

    await transactionHistoryRepositoryImpl
        .cancelPendingTransaction(cancelTransactionRequestModel);

    verify(mockTransactionHistoryDataSource
        .cancelPendingTransaction(cancelTransactionRequestModel));

    verifyNoMoreInteractions(mockTransactionHistoryDataSource);
  });

  test(
      'should call completePendingTransaction on TransactionHistoryDataSource with CommonApiResponseModel params',
      () async {
    final referenceId = 1;

    final completeTransactionRequestModel = CompleteTransactionRequestModel(
        pendingTxnBankRefNo: 1, docPath: '', transRefId: referenceId);

    final commonApiResponseModel = CommonApiResponseModel();

    when(mockTransactionHistoryDataSource
            .completePendingTransaction(completeTransactionRequestModel))
        .thenAnswer(
            (realInvocation) => Future.value(Right(commonApiResponseModel)));

    await transactionHistoryRepositoryImpl
        .confirmPendingTransaction(completeTransactionRequestModel);

    verify(mockTransactionHistoryDataSource
        .completePendingTransaction(completeTransactionRequestModel));

    verifyNoMoreInteractions(mockTransactionHistoryDataSource);
  });

  test(
      'should call requestTxnsPaymentModeFilters on TransactionHistoryDataSource',
      () async {
    final response = [TransactionPaymentModeFilterModel(code: 1, title: '')];

    when(mockTransactionHistoryDataSource.requestTxnsPaymentModeFilters())
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    await transactionHistoryRepositoryImpl.getTransactionFilters();

    verify(mockTransactionHistoryDataSource.requestTxnsPaymentModeFilters());

    verifyNoMoreInteractions(mockTransactionHistoryDataSource);
  });
}
