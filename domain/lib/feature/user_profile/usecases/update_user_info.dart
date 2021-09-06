import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/user_profile/entities/update_user_info_request.dart';
import 'package:domain/feature/user_profile/repositories/user_profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@singleton
class UpdateUserInfo
    implements UseCase<CommonApiResponse, UpdateUserInfoParams> {
  final UserProfileRepository userInfoRepository;

  UpdateUserInfo(this.userInfoRepository);

  @override
  Future<Either<Failure, CommonApiResponse>> call(
      UpdateUserInfoParams params) async {
    return await userInfoRepository
        .updateUserInfo(UpdateUserInfoRequest(params.mobile));
  }
}

class UpdateUserInfoParams extends Equatable {
  final String mobile;

  UpdateUserInfoParams(this.mobile);
  @override
  List<Object> get props => [mobile];
}
