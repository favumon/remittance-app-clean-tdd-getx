import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/user_profile/entities/verify_user_email_request.dart';
import 'package:domain/feature/user_profile/repositories/user_profile_repository.dart';
import 'package:domain/feature/user_profile/usecases/verify_user_email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_info_test.mocks.dart';

@GenerateMocks([UserProfileRepository])
main() {
  late MockUserProfileRepository mockUserInfoRepository;
  late VerifyUserEmail verifyUserEmail;
  setUp(() {
    mockUserInfoRepository = MockUserProfileRepository();
    verifyUserEmail = VerifyUserEmail(mockUserInfoRepository);
  });
  test('should call verifyUserEmail with email provided', () async {
    final String email = 'test@test.com';
    VerifyUserEmailParams verifyUserEmailParams = VerifyUserEmailParams(email);
    final verifyUserEmailRequest = VerifyUserEmailRequest(email);

    when(mockUserInfoRepository.verifyUserEmail(verifyUserEmailRequest))
        .thenAnswer(
            (realInvocation) => Future.value(Right(CommonApiResponse())));
    var result = await verifyUserEmail(verifyUserEmailParams);
    expect(result, Right(CommonApiResponse()));
    verify(mockUserInfoRepository.verifyUserEmail(verifyUserEmailRequest));
  });
}
