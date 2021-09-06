import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/identity_list/data_sources/identity_list_remote_data_source.dart';
import 'package:domain/feature/identity_list/entities/identity_details.dart';
import 'package:domain/feature/identity_list/repositories/identity_list_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IdentityListRepository)
class IdentityListRepositoryImpl extends IdentityListRepository {
  final IdentityListRemoteDataSource _addIdentityDataSource;

  IdentityListRepositoryImpl(this._addIdentityDataSource);

  @override
  Future<Either<Failure, List<IdentityDetails>>> getIdentities() async {
    return await _addIdentityDataSource.getIdentityList();
  }
}
