import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/user_profile/entities/update_user_info_request.dart';
import 'package:domain/feature/user_profile/repositories/user_profile_repository.dart';
import 'package:domain/feature/user_profile/usecases/update_user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'update_user_info_test.mocks.dart';

@GenerateMocks([UserProfileRepository])
main() {
  late UpdateUserInfo updateUserInfo;

  late MockUserProfileRepository mockUserInfoRepository;
  setUp(() {
    mockUserInfoRepository = MockUserProfileRepository();
    updateUserInfo = UpdateUserInfo(mockUserInfoRepository);
  });
  test(
      'should call method updateUserInfo on Repository with provided mobile number',
      () async {
    final mobileNo = '123456789';

    when(mockUserInfoRepository.updateUserInfo(UpdateUserInfoRequest(mobileNo)))
        .thenAnswer(
            (realInvocation) => Future.value(Right(CommonApiResponse())));
    final result = await updateUserInfo(UpdateUserInfoParams(mobileNo));
    expect(result, Right(CommonApiResponse()));
    verify(
        mockUserInfoRepository.updateUserInfo(UpdateUserInfoRequest(mobileNo)));
  });
  test('should return UserProfileUpdateFailure in case of failure', () async {
    final mobileNo = '123456789';

    when(mockUserInfoRepository.updateUserInfo(UpdateUserInfoRequest(mobileNo)))
        .thenAnswer(
            (realInvocation) => Future.value(Left(UserProfileUpdateFailure())));
    final result = await updateUserInfo(UpdateUserInfoParams(mobileNo));
    expect(result, Left(UserProfileUpdateFailure()));
    verify(
        mockUserInfoRepository.updateUserInfo(UpdateUserInfoRequest(mobileNo)));
  });
}
