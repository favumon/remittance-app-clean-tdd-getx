import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:domain/feature/settings/entities/change_biometric_auth_login_request.dart';
import 'package:domain/feature/settings/repositories/settings_repository.dart';
import 'package:domain/feature/settings/usecases/change_biometric_auth_login.dart';

import 'change_biometric_auth_login_test.mocks.dart';

@GenerateMocks([SettingsRepository])
main() {
  late MockSettingsRepository mockSettingsRepository;
  late ChangeBiometricAuthLogin changeBiometricAuthLogin;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    changeBiometricAuthLogin = ChangeBiometricAuthLogin(mockSettingsRepository);
  });

  test(
      'should get a null response from repository when changeBiometricAuthLogin called ',
      () async {
    final req = ChangeBiometricAuthLoginRequest(true);
    final params = ChangeBiometricAuthLoginParams(true);

    when(mockSettingsRepository.changeBiometricAuthLogin(req))
        .thenAnswer((realInvocation) async => Future.value(Right(null)));

    final result = await changeBiometricAuthLogin(params);

    expect(result, Right(null));

    verify(mockSettingsRepository.changeBiometricAuthLogin(req));

    verifyNoMoreInteractions(mockSettingsRepository);
  });
}
