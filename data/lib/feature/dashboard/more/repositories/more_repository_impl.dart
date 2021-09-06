import 'package:dartz/dartz.dart';
import 'package:data/feature/dashboard/more/datasources/more_datasources.dart';
import 'package:data/feature/dashboard/more/models/signout_request_model.dart';
import 'package:injectable/injectable.dart';

import 'package:domain/feature/dashboard/more/entity/signout_request.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/dashboard/more/repositories/more_repository.dart';

@LazySingleton(as: MoreRepository)
class MoreRepositoryImpl implements MoreRepository {
  final MoreDatasource _moreDatasource;

  MoreRepositoryImpl(this._moreDatasource);

  @override
  Future<Either<Failure, Null>> signOutUser(SignoutRequest request) {
    return _moreDatasource.signoutUser(SignoutRequestModel());
  }
}
