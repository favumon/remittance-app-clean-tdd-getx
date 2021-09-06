import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_count_request.dart';
import 'package:domain/feature/dashboard/notification/entity/notification_item_count.dart';
import 'package:domain/feature/dashboard/notification/repositories/notification_count_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetNotificationCount
    extends UseCase<NotificationCountItem, GetNotificationsParams> {
  final NotificationsCountRepository _notificationsRepository;

  GetNotificationCount(this._notificationsRepository);

  @override
  Future<Either<Failure, NotificationCountItem>> call(
      GetNotificationsParams params) async {
    return await _notificationsRepository
        .getNotificationCount(NotificationCountRequest());
  }
}

class GetNotificationsParams extends Equatable {
  GetNotificationsParams();

  @override
  List<Object?> get props => [];
}
