import 'package:dartz/dartz.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/notifications/entity/notification_read_request.dart';
import 'package:domain/feature/notifications/repositories/notifications_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:core/usecases/usecase.dart';

@lazySingleton
class UpdateNotificationReadStatus
    extends UseCase<Null, UpdateNotificationReadStatusParams> {
  final NotificationsRepository _notificationsRepository;

  UpdateNotificationReadStatus(this._notificationsRepository);

  @override
  Future<Either<Failure, Null>> call(
      UpdateNotificationReadStatusParams params) {
    return _notificationsRepository.updateNotificationReadStatus(
        NotificationReadRequest(notificationId: params.notificationId));
  }
}

class UpdateNotificationReadStatusParams extends Equatable {
  final int notificationId;

  UpdateNotificationReadStatusParams({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}
