import 'package:dartz/dartz.dart';

import 'package:core/error/failures.dart';
import 'package:domain/feature/dashboard/more/entity/signout_request.dart';

abstract class MoreRepository {
  Future<Either<Failure, Null>> signOutUser(SignoutRequest request);
}
