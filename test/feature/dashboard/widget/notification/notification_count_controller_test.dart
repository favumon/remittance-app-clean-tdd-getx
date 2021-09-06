import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_item_count.dart';
import 'package:domain/feature/dashboard/notification/usecases/get_notifiction_count.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/dashboard/widget/notification/notification_count_controller.dart';

import 'notification_count_controller_test.mocks.dart';

@GenerateMocks([GetNotificationCount, NavigationService])
main() {
  late MockGetNotificationCount mockGetNotificationCount;
  late MockNavigationService mockNavigationService;

  late NotificationCountController notificationCountController;

  setUp(() {
    mockGetNotificationCount = MockGetNotificationCount();
    mockNavigationService = MockNavigationService();

    notificationCountController = NotificationCountController(
        mockGetNotificationCount, mockNavigationService);
  });

  test(
      'should call GetNotificationCount usecase when initGetNotificationCount called',
      () {
    final params = GetNotificationsParams();

    when(mockGetNotificationCount(params)).thenAnswer((realInvocation) =>
        Future.value(Right(NotificationCountItem(unreadNotificationCount: 1))));

    notificationCountController.initGetNotificationCount();

    verify(mockGetNotificationCount(params));
  });
}
