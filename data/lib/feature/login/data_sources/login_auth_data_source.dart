import 'package:core/error/failures.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/login/model/login_auth_item_model.dart';
import 'package:data/feature/login/model/login_auth_request_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoginAuthDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  LoginAuthDataSource({
    required this.remoteApi,
    required this.apiEndpoints,
  });

  Future<Either<Failure, LoginAuthModel>> getLoginAuth(
      LoginAuthRequestModel loginAuthRequestModel) async {
    var response = await remoteApi.apiGet(apiEndpoints.loginAuth,
        queryParameters: loginAuthRequestModel.toJson());

    return response.fold(
        (l) => Left(l), (r) => Right(LoginAuthModel.fromMap(r)));
  }
}
