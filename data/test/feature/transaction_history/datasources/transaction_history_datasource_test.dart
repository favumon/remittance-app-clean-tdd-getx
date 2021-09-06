import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/transaction_history/models/transaction_payment_mode_filter_model.dart';
import 'package:data/core/device/image_picker.dart';
import 'package:data/feature/transaction_history/models/payment_mode_model.dart';
import 'package:data/feature/transaction_history/models/transaction_status_model.dart';
import 'package:data/core/models/common_api_response_model.dart';
import 'package:data/feature/transaction_history/models/cancel_transaction_request_model.dart';
import 'package:data/feature/transaction_history/models/complete_transaction_request_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_details_request_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_item_details_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_item_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_list_request_model.dart';
import 'package:data/feature/transaction_history/models/transaction_detail_request_model.dart';
import 'package:data/feature/transaction_history/models/transaction_details_item_model.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/feature/transaction_history/datasources/transaction_history_datasource.dart';
import 'package:data/feature/transaction_history/models/transaction_item_model.dart';
import 'package:data/feature/transaction_history/models/transaction_list_request_model.dart';
import 'package:data/core/remote_api.dart';

import 'transaction_history_datasource_test.mocks.dart';

@GenerateMocks([RemoteApi, ImagePicker])
main() {
  late MockRemoteApi mockRemoteApi;
  late TransactionHistoryDataSource transactionHistoryDataSource;
  final apiEndpoints = ApiEndpointsDev();
  late MockImagePicker mockImagePicker;

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    mockImagePicker = MockImagePicker();
    transactionHistoryDataSource = TransactionHistoryDataSource(
        mockRemoteApi, apiEndpoints, mockImagePicker);
  });

  test(
      'should return a List<TransactionItemModel> from RemoteApi when TransactionListRequestModel params are passed',
      () async {
    final map = jsonDecode(apiResposeMock('.json'));
    final TransactionListRequestModel transactionListRequestModel =
        TransactionListRequestModel(<int>[]);

    final transactionItemModelList = <TransactionItemModel>[
      TransactionItemModel(
          paymentMode: PaymentModeModel(code: 13, title: 'Bank Transfer'),
          beneficiaryName: 'Maria K K',
          lcAmount: 663.0,
          transactionStatus:
              TransactionStatusModel(code: 1, title: 'Successful'),
          lcCurrency: 'QAR',
          profileImageUrl: 'http://someurl.png',
          transactionDateTime: '2012-02-27T13:27:00.000',
          transactionRefId: 12345678765432),
    ];

    when(mockRemoteApi.apiGet(apiEndpoints.transactionHistoryList,
            queryParameters: transactionListRequestModel.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await transactionHistoryDataSource
        .requestTransactionHistory(transactionListRequestModel);

    result.fold(
        (l) => null, (r) => {expect(transactionItemModelList[0], r[0])});

    // expect(Right(notitificationItemModelList), result);
  });

  test(
      'should return a List<PendingTransactionItemModel> from RemoteApi when requestPendingTransactionHistory called with PendingTransactionListRequestModel',
      () async {
    final map =
        jsonDecode(apiResposeMock('pending_transaction_item_response.json'));
    final pendingTransactionListRequestModel =
        PendingTransactionListRequestModel(<int>[]);

    final pendingTransactionItemModelList = <PendingTransactionItemModel>[
      PendingTransactionItemModel(
          paymentMode: PaymentModeModel(code: 13, title: 'Bank Transfer'),
          beneficiaryName: 'Maria K K',
          lcAmount: 663.0,
          transactionStatus:
              TransactionStatusModel(code: 0, title: 'In process'),
          lcCurrency: 'QAR',
          profileImageUrl: 'http://someurl.png',
          transactionDateTime: '2012-02-27T13:27:00.000',
          transactionRefId: 12345678765432),
    ];

    when(mockRemoteApi.apiGet(apiEndpoints.pendingTransactionHistoryList,
            queryParameters: pendingTransactionListRequestModel.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await transactionHistoryDataSource
        .requestPendingTransactionHistory(pendingTransactionListRequestModel);

    result.fold(
        (l) => null, (r) => {expect(pendingTransactionItemModelList[0], r[0])});
  });

  test(
      'should return a PendingTransactionItemDetailsModel from RemoteApi when requestPendingTransactionDetails called with PendingTransactionDetailsRequestModel',
      () async {
    final map = jsonDecode(
        apiResposeMock('pending_transaction_item_details_response.json'));

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

    when(mockRemoteApi.apiGet(apiEndpoints.pendingTransactionDetails,
            queryParameters: pendingTransactionDetailsRequestModel.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result =
        await transactionHistoryDataSource.requestPendingTransactionDetails(
            pendingTransactionDetailsRequestModel);

    expect(result, Right(pendingTransactionItemDetailsModel));
  });

  test(
      'should return a TransactionDetailsItemModel from RemoteApi when requestTransactionDetails called with TransactionDetailsRequestModel',
      () async {
    final map =
        jsonDecode(apiResposeMock('transaction_item_details_response.json'));

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
      paymentMode: PaymentModeModel(code: 13, title: 'Bank Transfer'),
      beneficiaryName: 'Maria K K',
      transactionStatus: TransactionStatusModel(code: 1, title: 'Successful'),
      lcCurrency: 'QAD',
      branchName: 'Ernakulam',
      cityName: 'Kochi',
      countryName: 'India',
      swiftCode: 'UVTN00291928',
    );

    when(mockRemoteApi.apiGet(apiEndpoints.transactionDetails,
            queryParameters: transactionDetailsRequestModel.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await transactionHistoryDataSource
        .requestTransactionDetails(transactionDetailsRequestModel);

    expect(result, Right(transactionDetailsItemModel));
  });

  test(
      'should return a CommonApiResponseModel from RemoteApi when cancelPendingTransaction called with CancelTransactionRequestModel',
      () async {
    final map = <String, dynamic>{};
    // jsonDecode(apiResposeMock('transaction_item_details_response.json'));

    final referenceId = 1;
    final reason = '';

    final cancelTransactionRequestModel =
        CancelTransactionRequestModel(referenceId, reason);

    final commonApiResponseModel = CommonApiResponseModel();

    when(mockRemoteApi.apiPost(apiEndpoints.cancelPendingTransaction,
            data: cancelTransactionRequestModel.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await transactionHistoryDataSource
        .cancelPendingTransaction(cancelTransactionRequestModel);

    expect(result, Right(commonApiResponseModel));
  });

  test(
      'should return a CommonApiResponseModel from RemoteApi when completePendingTransaction called with CompleteTransactionRequestModel',
      () async {
    final map = <String, dynamic>{};
    // jsonDecode(apiResposeMock('transaction_item_details_response.json'));

    final referenceId = 1;

    final completeTransactionRequestModel = CompleteTransactionRequestModel(
        docPath: '/assets/images/add_signature.svg',
        pendingTxnBankRefNo: 1,
        transRefId: referenceId);

    final commonApiResponseModel = CommonApiResponseModel.fromMap(map);

    when(mockRemoteApi.apiPost(apiEndpoints.completePendingTransaction,
            data: await completeTransactionRequestModel.toFormData()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await transactionHistoryDataSource
        .completePendingTransaction(completeTransactionRequestModel);

    expect(result, Right(commonApiResponseModel));
  });

  test(
      'should return a TransactionPaymentModeFilterModel from RemoteApi when requestTxnsPaymentModeFilters called',
      () async {
    final map =
        jsonDecode(apiResposeMock('transaction_history_filter_reponse.json'));

    final list = [
      TransactionPaymentModeFilterModel(title: 'Bank Transfer', code: 13)
    ];

    when(mockRemoteApi.apiGet(
      apiEndpoints.transactionFilterList,
    )).thenAnswer((realInvocation) => Future.value(Right(map)));

    var result =
        await transactionHistoryDataSource.requestTxnsPaymentModeFilters();

    result.fold((l) => null, (r) => {expect(r[0], list[0])});

    // expect(result, Right(list));
  });
}
