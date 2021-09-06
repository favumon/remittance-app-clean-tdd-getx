import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/dashboard/more/entity/signout_request.dart';
import 'package:domain/feature/dashboard/more/repositories/more_repository.dart';

@lazySingleton
class SignOut extends UseCase<Null, SignoutRequestParams> {
  final MoreRepository _moreRepository;

  SignOut(this._moreRepository);

  @override
  Future<Either<Failure, Null>> call(SignoutRequestParams params) {
    return _moreRepository.signOutUser(SignoutRequest());
  }
}

class SignoutRequestParams extends Equatable {
  SignoutRequestParams();

  @override
  List<Object?> get props => [];
}
