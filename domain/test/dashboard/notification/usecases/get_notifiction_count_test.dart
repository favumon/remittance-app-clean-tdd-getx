import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/dashboard/notification/usecases/get_notifiction_count.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_count_request.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_item_count.dart';
import 'package:domain/feature/dashboard/notification/repositories/notification_count_repository.dart';

import 'get_notifiction_count_test.mocks.dart';

@GenerateMocks([NotificationsCountRepository])
main() {
  late MockNotificationsCountRepository mockNotificationsCountRepository;
  late GetNotificationCount getNotificationCount;

  setUp(() {
    mockNotificationsCountRepository = MockNotificationsCountRepository();
    getNotificationCount =
        GetNotificationCount(mockNotificationsCountRepository);
  });

  test('should get NotificationCountItem from NotificationsCountRepository',
      () async {
    final params = GetNotificationsParams();
    final response = NotificationCountItem(unreadNotificationCount: 1);

    when(mockNotificationsCountRepository
            .getNotificationCount(NotificationCountRequest()))
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    var result = await getNotificationCount(params);

    expect(result, Right(response));
  });
}
