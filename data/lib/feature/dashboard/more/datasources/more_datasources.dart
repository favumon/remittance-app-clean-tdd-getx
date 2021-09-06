import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import 'package:core/error/failures.dart';
import 'package:data/feature/dashboard/more/models/signout_request_model.dart';

@lazySingleton
class MoreDatasource {
  MoreDatasource();

  Future<Either<Failure, Null>> signoutUser(SignoutRequestModel requestModel) {
    //TODO Add localstorage keys removal
    return Future.value(Right(null));
  }
}
