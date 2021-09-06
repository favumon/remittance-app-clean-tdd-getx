import 'package:domain/feature/notifications/entity/notification_read_request.dart';
import 'package:domain/feature/notifications/entity/notification_request.dart';
import 'package:domain/feature/notifications/entity/notification_item.dart';
import 'package:domain/feature/notifications/repositories/notifications_repository.dart';
import 'package:domain/feature/notifications/usecases/get_notifications.dart';
import 'package:domain/feature/notifications/usecases/update_notification_read_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'get_notifications_test.mocks.dart';

@GenerateMocks([NotificationsRepository])
main() {
  late MockNotificationsRepository mockNotificationsRepository;
  late GetNotifications getNotifications;
  late UpdateNotificationReadStatus updateNotificationReadStatus;

  setUp(() {
    mockNotificationsRepository = MockNotificationsRepository();
    getNotifications = GetNotifications(mockNotificationsRepository);
    updateNotificationReadStatus =
        UpdateNotificationReadStatus(mockNotificationsRepository);
  });

  test(
      'should call getNotifications on NotificationRepository with NotificationRequest provided',
      () async {
    final GetNotificationsParams getNotificationsParams =
        GetNotificationsParams();
    final NotificationRequest notificationRequest = NotificationRequest();
    final List<NotificationItem> notificationList = <NotificationItem>[];

    when(mockNotificationsRepository.getNotifications(notificationRequest))
        .thenAnswer((realInvocation) => Future.value(Right(notificationList)));

    var result = await getNotifications(getNotificationsParams);

    verify(mockNotificationsRepository.getNotifications(notificationRequest));

    expect(Right(notificationList), result);

    verifyNoMoreInteractions(mockNotificationsRepository);
  });

  test(
      'should call updateNotificationReadStatus on NotificationRepository with NotificationReadRequest provided',
      () async {
    final NotificationReadRequest notificationReadRequest =
        NotificationReadRequest(notificationId: 1);

    final UpdateNotificationReadStatusParams
        updateNotificationReadStatusParams =
        UpdateNotificationReadStatusParams(notificationId: 1);

    when(mockNotificationsRepository
            .updateNotificationReadStatus(notificationReadRequest))
        .thenAnswer((realInvocation) => Future.value(Right(null)));

    var result =
        await updateNotificationReadStatus(updateNotificationReadStatusParams);

    verify(mockNotificationsRepository
        .updateNotificationReadStatus(notificationReadRequest));

    expect(Right(null), result);

    verifyNoMoreInteractions(mockNotificationsRepository);
  });
}
