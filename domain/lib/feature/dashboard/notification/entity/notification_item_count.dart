import 'package:equatable/equatable.dart';

class NotificationCountItem extends Equatable {
  final int unreadNotificationCount;

  NotificationCountItem({required this.unreadNotificationCount});

  @override
  List<Object?> get props => [unreadNotificationCount];
}
