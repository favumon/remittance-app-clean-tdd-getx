import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/settings/entities/biometric_auth_login_enabled.dart';
import 'package:domain/feature/settings/usecases/get_biometric_auth_enabled.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:domain/feature/settings/repositories/settings_repository.dart';

import 'get_biometric_auth_enabled_test.mocks.dart';

@GenerateMocks([SettingsRepository])
main() {
  late MockSettingsRepository mockSettingsRepository;
  late GetBiometricAuthEnabled getBiometricAuthEnabled;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
    getBiometricAuthEnabled = GetBiometricAuthEnabled(mockSettingsRepository);
  });

  test(
      'should get BiometricAuthLoginEnabled when getBiometrciAuthLoginEnabledStatus called from repository ',
      () async {
    final params = NoParams();

    final res = BiometricAuthLoginEnabled();

    when(mockSettingsRepository.getBiometrciAuthLoginEnabledStatus())
        .thenAnswer((realInvocation) async => Future.value(Right(res)));

    final result = await getBiometricAuthEnabled(params);

    expect(result, Right(res));

    verify(mockSettingsRepository.getBiometrciAuthLoginEnabledStatus());

    verifyNoMoreInteractions(mockSettingsRepository);
  });
}
