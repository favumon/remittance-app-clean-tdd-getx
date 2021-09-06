import 'package:core/error/failures.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/notifications/models/notification_item_model.dart';
import 'package:data/feature/notifications/models/notification_read_request_model.dart';
import 'package:data/feature/notifications/models/notification_request_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

@lazySingleton
class NotificationDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  NotificationDataSource({
    required this.remoteApi,
    required this.apiEndpoints,
  });

  Future<Either<Failure, List<NotificationItemModel>>> getNotifications(
      NotificationRequestModel notificationRequestModel) async {
    var response = await remoteApi.apiGet(apiEndpoints.geNotifications,
        queryParameters: notificationRequestModel.toJson());

    return response.fold((l) => Left(l), (r) {
      return Right(
        (r as List)
            .map<NotificationItemModel>(
              (e) => NotificationItemModel.fromMap(e),
            )
            .toList(),
      );
    });
  }

  Future<Either<Failure, Null>> updateNotificationReadStatus(
      NotificationReadRequestModel notificaionReadRequestModel) async {
    var res = await remoteApi.apiPost(apiEndpoints.updateNotificationReadStatus,
        data: notificaionReadRequestModel.toMap());

    return res.fold((l) => Left(l), (r) => Right(null));
  }
}
