import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/login/entities/login_auth_request.dart';
import 'package:domain/feature/login/entities/login_auth_item.dart';

abstract class LoginAuthRepository {
  Future<Either<Failure, LoginAuthItem>> getLoginAuth(
      LoginAuthRequest loginAuthRequest);
}
