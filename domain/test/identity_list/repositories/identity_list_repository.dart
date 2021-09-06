import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/identity_data.dart';

abstract class IdentityListRepository {
  Future<Either<Failure, List<IdentityData>>> getIdentities();
}
