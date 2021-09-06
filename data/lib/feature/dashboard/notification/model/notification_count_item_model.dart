import 'package:domain/feature/dashboard/notification/entity/notification_item_count.dart';

class NotificationCountModel extends NotificationCountItem {
  final int unreadNotificationCount;
  NotificationCountModel({required this.unreadNotificationCount})
      : super(unreadNotificationCount: unreadNotificationCount);

  factory NotificationCountModel.fromMap(Map<String, dynamic> json) {
    return NotificationCountModel(
        unreadNotificationCount: json['unread_notification_count']);
  }
}
