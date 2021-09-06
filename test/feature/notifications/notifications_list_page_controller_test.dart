import 'package:dartz/dartz.dart';
import 'package:domain/feature/notifications/usecases/get_notifications.dart';
import 'package:domain/feature/notifications/usecases/update_notification_read_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/feature/notifications/controllers/notifications_list_page_controller.dart';

import 'notifications_list_page_controller_test.mocks.dart';

@GenerateMocks([GetNotifications, UpdateNotificationReadStatus, AlertService])
main() {
  late MockGetNotifications mockGetNotifications;
  late MockUpdateNotificationReadStatus mockUpdateNotificationReadStatus;
  late MockAlertService mockAlertService;
  late NotificationListPageController notificationListPageController;

  setUp(() {
    mockGetNotifications = MockGetNotifications();
    mockUpdateNotificationReadStatus = MockUpdateNotificationReadStatus();
    mockAlertService = MockAlertService();
    notificationListPageController = NotificationListPageController(
        mockGetNotifications,
        mockUpdateNotificationReadStatus,
        mockAlertService);
  });

  test('should call GetNotifications usecase', () async {
    when(mockGetNotifications(GetNotificationsParams()))
        .thenAnswer((realInvocation) => Future.value(Right([])));

    await notificationListPageController.initGetNotification();

    verify(mockGetNotifications(GetNotificationsParams()));
  });

  test('should call UpdateNotificationReadStatus usecase for a notificationId',
      () async {
    when(mockUpdateNotificationReadStatus(
            UpdateNotificationReadStatusParams(notificationId: 1)))
        .thenAnswer((realInvocation) => Future.value(Right(null)));

    await notificationListPageController.updateNotificationStatus(1);

    verify(mockUpdateNotificationReadStatus(
        UpdateNotificationReadStatusParams(notificationId: 1)));
  });
}
