import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:domain/feature/notifications/entity/notification_request.dart';
import 'package:domain/feature/notifications/entity/notification_item.dart';
import 'package:domain/feature/notifications/repositories/notifications_repository.dart';
import 'package:core/usecases/usecase.dart';

@lazySingleton
class GetNotifications
    extends UseCase<List<NotificationItem>, GetNotificationsParams> {
  final NotificationsRepository _notificationsRepository;

  GetNotifications(this._notificationsRepository);

  @override
  Future<Either<Failure, List<NotificationItem>>> call(
      GetNotificationsParams params) async {
    return await _notificationsRepository
        .getNotifications(NotificationRequest());
  }
}

class GetNotificationsParams extends Equatable {
  GetNotificationsParams();

  @override
  List<Object?> get props => [];
}
