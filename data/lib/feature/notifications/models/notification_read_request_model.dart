import 'package:domain/feature/notifications/entity/notification_read_request.dart';

class NotificationReadRequestModel extends NotificationReadRequest {
  final int notificationId;

  NotificationReadRequestModel({required this.notificationId})
      : super(notificationId: notificationId);

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
    };
  }
}
