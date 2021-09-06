import 'package:core/error/failures.dart';
import 'package:data/feature/login/data_sources/login_auth_data_source.dart';
import 'package:data/feature/login/model/login_auth_request_model.dart';
import 'package:domain/feature/login/entities/login_auth_request.dart';
import 'package:domain/feature/login/entities/login_auth_item.dart';
import 'package:domain/feature/login/repositories/login_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LoginAuthRepository)
class LoginAuthRepositoriesImpl extends LoginAuthRepository {
  final LoginAuthDataSource _loginAuthDataSource;

  LoginAuthRepositoriesImpl(this._loginAuthDataSource);

  @override
  Future<Either<Failure, LoginAuthItem>> getLoginAuth(
      LoginAuthRequest loginAuthRequest) {
    return _loginAuthDataSource.getLoginAuth(LoginAuthRequestModel(
        userName: loginAuthRequest.userName,
        password: loginAuthRequest.password));
  }
}
