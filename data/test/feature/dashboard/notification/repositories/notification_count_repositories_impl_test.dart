import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/notification/model/notification_count_item_model.dart';
import 'package:data/feature/dashboard/notification/data_sources/notification_count_data_source.dart';
import 'package:data/feature/dashboard/notification/model/notifiction_count_request_model.dart';
import 'package:data/feature/dashboard/notification/repositories/notification_count_repositories_impl.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_count_request.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_item_count.dart';

import 'notification_count_repositories_impl_test.mocks.dart';

@GenerateMocks([NotificationCountDataSource])
main() {
  late MockNotificationCountDataSource mockNotificationCountDataSource;
  late NotificationsCountRepositoriesImpl notificationsCountRepositoriesImpl;

  setUp(() {
    mockNotificationCountDataSource = MockNotificationCountDataSource();
    notificationsCountRepositoriesImpl =
        NotificationsCountRepositoriesImpl(mockNotificationCountDataSource);
  });

  test('should get NotificationCountItem from NotificationCountDataSource',
      () async {
    final requestModel = NotificationCountRequestModel();
    final NotificationCountRequest request = requestModel;

    final notificationCountModel =
        NotificationCountModel(unreadNotificationCount: 1);
    final NotificationCountItem notificationCountItem = notificationCountModel;

    when(mockNotificationCountDataSource.getNotificationCount(requestModel))
        .thenAnswer(
            (realInvocation) => Future.value(Right(notificationCountModel)));

    var result =
        await notificationsCountRepositoriesImpl.getNotificationCount(request);

    expect(result, Right(notificationCountItem));

    verify(mockNotificationCountDataSource.getNotificationCount(requestModel));
    verifyNoMoreInteractions(mockNotificationCountDataSource);
  });
}
