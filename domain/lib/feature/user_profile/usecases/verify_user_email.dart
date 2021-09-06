import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/user_profile/entities/verify_user_email_request.dart';
import 'package:domain/feature/user_profile/repositories/user_profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@singleton
class VerifyUserEmail
    implements UseCase<CommonApiResponse, VerifyUserEmailParams> {
  final UserProfileRepository userInfoRepository;

  VerifyUserEmail(this.userInfoRepository);

  @override
  Future<Either<Failure, CommonApiResponse>> call(
      VerifyUserEmailParams params) async {
    return await userInfoRepository
        .verifyUserEmail(VerifyUserEmailRequest(params.email));
  }
}

class VerifyUserEmailParams extends Equatable {
  final String email;

  VerifyUserEmailParams(this.email);
  @override
  List<Object> get props => [email];
}
