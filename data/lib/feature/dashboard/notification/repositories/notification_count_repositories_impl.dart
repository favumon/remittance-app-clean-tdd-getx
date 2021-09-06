import 'package:core/error/failures.dart';
import 'package:data/feature/dashboard/notification/data_sources/notification_count_data_source.dart';
import 'package:data/feature/dashboard/notification/model/notifiction_count_request_model.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_count_request.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_item_count.dart';
import 'package:domain/feature/dashboard/notification/repositories/notification_count_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationsCountRepository)
class NotificationsCountRepositoriesImpl extends NotificationsCountRepository {
  final NotificationCountDataSource _notificationDataSource;

  NotificationsCountRepositoriesImpl(this._notificationDataSource);

  @override
  Future<Either<Failure, NotificationCountItem>> getNotificationCount(
      NotificationCountRequest notificationRequest) {
    return _notificationDataSource
        .getNotificationCount(NotificationCountRequestModel());
  }
}
