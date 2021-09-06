import 'package:equatable/equatable.dart';

class NotificationReadRequest extends Equatable {
  final int notificationId;

  NotificationReadRequest({required this.notificationId});

  @override
  List<Object?> get props => [this.notificationId];
}
