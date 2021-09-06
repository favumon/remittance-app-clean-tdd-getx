import 'package:data/feature/notifications/data_sources/notification_data_sources.dart';
import 'package:data/feature/notifications/models/notification_read_request_model.dart';
import 'package:data/feature/notifications/models/notification_request_model.dart';
import 'package:domain/feature/notifications/entity/notification_item.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/notifications/entity/notification_read_request.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:domain/feature/notifications/repositories/notifications_repository.dart';
import 'package:domain/feature/notifications/entity/notification_request.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoriesImpl extends NotificationsRepository {
  final NotificationDataSource _notificationDataSource;

  NotificationsRepositoriesImpl(this._notificationDataSource);

  @override
  Future<Either<Failure, List<NotificationItem>>> getNotifications(
      NotificationRequest notificationRequest) {
    return _notificationDataSource.getNotifications(NotificationRequestModel());
  }

  @override
  Future<Either<Failure, Null>> updateNotificationReadStatus(
      NotificationReadRequest notificationReadRequest) {
    return _notificationDataSource.updateNotificationReadStatus(
        NotificationReadRequestModel(
            notificationId: notificationReadRequest.notificationId));
  }
}
