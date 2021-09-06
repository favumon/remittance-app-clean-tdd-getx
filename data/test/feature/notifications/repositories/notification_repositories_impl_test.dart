import 'package:data/feature/notifications/data_sources/notification_data_sources.dart';
import 'package:data/feature/notifications/models/notification_item_model.dart';
import 'package:data/feature/notifications/models/notification_read_request_model.dart';
import 'package:data/feature/notifications/models/notification_request_model.dart';
import 'package:data/feature/notifications/repositories/notification_repositories_impl.dart';
import 'package:domain/feature/notifications/entity/notification_read_request.dart';
import 'package:domain/feature/notifications/entity/notification_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'notification_repositories_impl_test.mocks.dart';

@GenerateMocks([NotificationDataSource])
main() {
  late MockNotificationDataSource mockNotificationDataSource;
  late NotificationsRepositoriesImpl notificationsRepositoriesImpl;

  setUp(() {
    mockNotificationDataSource = MockNotificationDataSource();
    notificationsRepositoriesImpl =
        NotificationsRepositoriesImpl(mockNotificationDataSource);
  });

  test(
      'should call getNotifications on NotificationDataSource with NotificationReqestModel params',
      () async {
    final NotificationRequestModel notificationRequestModel =
        NotificationRequestModel();
    final List<NotificationItemModel> notificationList =
        <NotificationItemModel>[];

    when(mockNotificationDataSource.getNotifications(notificationRequestModel))
        .thenAnswer((realInvocation) => Future.value(Right(notificationList)));

    await notificationsRepositoriesImpl.getNotifications(NotificationRequest());

    verify(
        mockNotificationDataSource.getNotifications(notificationRequestModel));

    verifyNoMoreInteractions(mockNotificationDataSource);
  });

  test(
      'should call updateNotificationReadStatus on NotificationDataSource with NotificationReadReqestModel params',
      () async {
    final NotificationReadRequestModel notificationReadRequestModel =
        NotificationReadRequestModel(notificationId: 1);

    final NotificationReadRequest notificationReadRequest =
        NotificationReadRequest(notificationId: 1);

    when(mockNotificationDataSource
            .updateNotificationReadStatus(notificationReadRequestModel))
        .thenAnswer((realInvocation) => Future.value(Right(null)));

    await notificationsRepositoriesImpl
        .updateNotificationReadStatus(notificationReadRequest);

    verify(mockNotificationDataSource
        .updateNotificationReadStatus(notificationReadRequestModel));

    verifyNoMoreInteractions(mockNotificationDataSource);
  });
}
