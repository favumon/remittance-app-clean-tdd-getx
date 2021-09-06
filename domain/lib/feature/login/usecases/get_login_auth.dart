import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/login/entities/login_auth_request.dart';
import 'package:domain/feature/login/entities/login_auth_item.dart';
import 'package:domain/feature/login/repositories/login_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetLoginAuth extends UseCase<LoginAuthItem, GetLoginAuthParams> {
  final LoginAuthRepository _loginAuthRepository;

  GetLoginAuth(this._loginAuthRepository);

  @override
  Future<Either<Failure, LoginAuthItem>> call(GetLoginAuthParams params) async {
    return await _loginAuthRepository.getLoginAuth(
        LoginAuthRequest(userName: params.userName, password: params.password));
  }
}

class GetLoginAuthParams extends Equatable {
  final String userName;
  final String password;

  GetLoginAuthParams({required this.userName, required this.password});

  @override
  List<Object?> get props => [userName, password];
}
