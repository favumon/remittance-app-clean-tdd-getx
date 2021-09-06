import 'package:core/error/failures.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/dashboard/easy_resend/model/easy_resend_item_model.dart';
import 'package:data/feature/dashboard/easy_resend/model/easy_resend_request_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EasyResendtDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  EasyResendtDataSource({
    required this.remoteApi,
    required this.apiEndpoints,
  });

  Future<Either<Failure, List<EasyResendItemModel>>> getEasyResend(
      EasyResendRequestModel easyResendRequestModel) async {
    var response = await remoteApi.apiGet(apiEndpoints.easyResendList,
        queryParameters: easyResendRequestModel.toJson());

    return response.fold((l) => Left(l), (r) {
      return Right((r as List)
          .map<EasyResendItemModel>(
            (e) => EasyResendItemModel.fromMap(e),
          )
          .toList());
    });
  }
}
