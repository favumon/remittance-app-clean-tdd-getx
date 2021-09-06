import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/user_profile/entities/user_info.dart';
import 'package:domain/feature/user_profile/repositories/user_profile_repository.dart';
import 'package:domain/feature/user_profile/usecases/get_user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_info_test.mocks.dart';

@GenerateMocks([UserProfileRepository])
main() {
  late GetUserInfo getUserInfo;
  late MockUserProfileRepository mockUserInfoRepository;
  setUp(() {
    mockUserInfoRepository = MockUserProfileRepository();
    getUserInfo = GetUserInfo(mockUserInfoRepository);
  });
  test('should get UserInfo entity from repository', () async {
    final userInfo = UserInfo(
        firstName: 'First ',
        middleName: 'Middle',
        lastName: 'Last',
        phoneNumber: '12345678',
        email: 'test@test.com',
        profileImage: 'someurl.co/image.png');

    when(mockUserInfoRepository.getUserInfo())
        .thenAnswer((realInvocation) => Future.value(Right(userInfo)));
    final result = await getUserInfo(NoParams());
    expect(result, Right(userInfo));
    verify(mockUserInfoRepository.getUserInfo());
  });
}
