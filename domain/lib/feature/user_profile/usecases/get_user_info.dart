import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/user_profile/entities/user_info.dart';
import 'package:domain/feature/user_profile/repositories/user_profile_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetUserInfo implements UseCase<UserInfo, NoParams> {
  final UserProfileRepository userInfoRepository;

  GetUserInfo(this.userInfoRepository);

  @override
  Future<Either<Failure, UserInfo>> call(NoParams params) async {
    return await userInfoRepository.getUserInfo();
  }
}
