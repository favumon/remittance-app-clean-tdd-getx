import 'package:dartz/dartz.dart';
import 'package:data/feature/user_profile/data_sources/user_profile_remote_data_source.dart';
import 'package:data/feature/user_profile/models/user_info_model.dart';
import 'package:data/feature/user_profile/repositories/user_profile_repository_impl.dart';
import 'package:domain/feature/user_profile/entities/user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_profile_repository_impl_test.mocks.dart';

@GenerateMocks([UserProfileRemoteDataSource])
main() {
  late MockUserProfileRemoteDataSource mockUserProfileRemoteDataSource;
  late UserProfileRepositoryImpl userProfileRepositoryImpl;

  setUp(() {
    mockUserProfileRemoteDataSource = MockUserProfileRemoteDataSource();
    userProfileRepositoryImpl =
        UserProfileRepositoryImpl(mockUserProfileRemoteDataSource);
  });
  test('should get UserInfo from Remotedatasource', () async {
    final userModel = UserInfoModel(
        firstName: 'Firstname',
        email: 'test@test.com',
        lastName: 'Last name',
        middleName: 'M',
        phoneNumber: '123456789',
        profileImage: 'http://www.someurl.com/image');
    final UserInfo user = userModel;

    when(mockUserProfileRemoteDataSource.getUserInfo())
        .thenAnswer((realInvocation) => Future.value(Right(userModel)));
    var result = await userProfileRepositoryImpl.getUserInfo();

    expect(result, Right(user));

    verify(mockUserProfileRemoteDataSource.getUserInfo());
    verifyNoMoreInteractions(mockUserProfileRemoteDataSource);
  });
}
