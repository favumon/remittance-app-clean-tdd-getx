import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/change_password/models/change_password_request_model.dart';
import 'package:data/feature/change_password/models/change_password_response_model.dart';

@lazySingleton
class ChangePasswordDatasource {
  final RemoteApi _remoteApi;
  final ApiEndpoints _apiEndpoints;

  ChangePasswordDatasource(this._remoteApi, this._apiEndpoints);

  Future<Either<Failure, ChangePasswordResponseModel>> changePassword(
      ChangePasswordRequestModel requestModel) async {
    var res = await _remoteApi.apiPost(
      _apiEndpoints.changePassword,
      data: requestModel.toMap(),
    );

    return res.fold(
      (l) => Left(l),
      (r) => Right(ChangePasswordResponseModel.fromMap(r)),
    );
  }
}
