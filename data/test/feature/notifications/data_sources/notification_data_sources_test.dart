import 'dart:convert';

import 'package:data/feature/notifications/models/disbursal_mode_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/notifications/data_sources/notification_data_sources.dart';
import 'package:data/feature/notifications/models/notification_item_model.dart';
import 'package:data/feature/notifications/models/notification_read_request_model.dart';
import 'package:data/feature/notifications/models/notification_request_model.dart';
import 'package:data/feature/notifications/models/payment_mode_model.dart';
import 'package:data/feature/notifications/models/transaction_status_model.dart';

import 'notification_data_sources_test.mocks.dart';

@GenerateMocks([RemoteApi])
main() {
  late MockRemoteApi mockRemoteApi;
  late NotificationDataSource notificationDataSource;
  final apiEndpoints = ApiEndpointsDev();

  setUp(() {
    mockRemoteApi = MockRemoteApi();
    notificationDataSource = NotificationDataSource(
        remoteApi: mockRemoteApi, apiEndpoints: apiEndpoints);
  });

  test(
      'should return a List<NotificationItemModel> from RemoteApi when NotificationRequestModel params are passed',
      () async {
    final map = jsonDecode(apiResposeMock('notification_list_response.json'));
    final NotificationRequestModel notificationRequestModel =
        NotificationRequestModel();
    final List<NotificationItemModel> notitificationItemModelList =
        <NotificationItemModel>[
      NotificationItemModel(
          id: 1,
          refrenceNo: 1233455522,
          ttNumber: '1234565432',
          paymentMode: PaymentModeModel(code: 'BT', title: 'Bank Transfer'),
          beneficiaryName: 'Akhil',
          agentName: 'Axis Bank',
          swiftCode: 'QWE92889000119',
          accountNo: '1717379817',
          dateTimeOfTransaction: '2012-02-27T13:27:00.000',
          fcAmount: 12.0,
          rate: 7.0,
          lcAmount: 90.0,
          commision: 9.0,
          charges: 0.0,
          vat: 0.0,
          discount: 0.0,
          netAmount: 29.0,
          transactionStatus:
              TransactionStatusModel(code: 0, title: 'In Process'),
          transactionCompleteDateTime: '2012-02-28T14:50:00.000',
          lcCurrencyCode: 'KWD',
          readStatus: false,
          fcCurrencyCode: 'INR',
          disbursalMode: DisbursalModeModel(code: 'CP', title: 'Cash pickup')),
    ];

    when(mockRemoteApi.apiGet(apiEndpoints.geNotifications,
            queryParameters: notificationRequestModel.toJson()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result =
        await notificationDataSource.getNotifications(notificationRequestModel);

    result.fold(
        (l) => null, (r) => {expect(notitificationItemModelList[0], r[0])});

    // expect(Right(notitificationItemModelList), result);
  });

  test(
      'should have NO Failure return from RemoteApi when NotificationDataSource called with NotificationReadReauestModel params',
      () async {
    final map = <String, dynamic>{};
    final NotificationReadRequestModel notificaionReadRequestModel =
        NotificationReadRequestModel(notificationId: 1);

    when(mockRemoteApi.apiPost(apiEndpoints.updateNotificationReadStatus,
            data: notificaionReadRequestModel.toMap()))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await notificationDataSource
        .updateNotificationReadStatus(notificaionReadRequestModel);

    expect(Right(null), result);
  });
}
