import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/identity_list/entities/identity_details.dart';

abstract class IdentityListRepository {
  Future<Either<Failure, List<IdentityDetails>>> getIdentities();
}
