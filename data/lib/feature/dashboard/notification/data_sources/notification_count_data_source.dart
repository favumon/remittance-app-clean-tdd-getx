import 'package:core/error/failures.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/dashboard/notification/model/notification_count_item_model.dart';
import 'package:data/feature/dashboard/notification/model/notifiction_count_request_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationCountDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  NotificationCountDataSource({
    required this.remoteApi,
    required this.apiEndpoints,
  });

  Future<Either<Failure, NotificationCountModel>> getNotificationCount(
      NotificationCountRequestModel notificationRequestModel) async {
    var response = await remoteApi.apiGet(apiEndpoints.notificationCount,
        queryParameters: notificationRequestModel.toJson());

    return response.fold(
        (l) => Left(l), (r) => Right(NotificationCountModel.fromMap(r)));
  }
}
