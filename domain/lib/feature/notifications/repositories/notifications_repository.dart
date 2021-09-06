import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/notifications/entity/notification_read_request.dart';
import 'package:domain/feature/notifications/entity/notification_request.dart';
import 'package:domain/feature/notifications/entity/notification_item.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationItem>>> getNotifications(
      NotificationRequest notificationRequest);
  Future<Either<Failure, Null>> updateNotificationReadStatus(
      NotificationReadRequest notificationReadRequest);
}
