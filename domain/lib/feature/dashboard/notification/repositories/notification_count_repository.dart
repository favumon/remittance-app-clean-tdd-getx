import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_count_request.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_item_count.dart';

abstract class NotificationsCountRepository {
  Future<Either<Failure, NotificationCountItem>> getNotificationCount(
      NotificationCountRequest notificationRequest);
}
