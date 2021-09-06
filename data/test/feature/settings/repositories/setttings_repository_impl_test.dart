import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/settings/models/change_biometric_auth_login_request_model.dart';
import 'package:domain/feature/settings/entities/change_biometric_auth_login_request.dart';
import 'package:data/feature/settings/repositories/setttings_repository_impl.dart';
import 'package:data/feature/settings/datasources/settings_datasources.dart';

import 'setttings_repository_impl_test.mocks.dart';

@GenerateMocks([SettigsDatasources])
main() {
  late MockSettigsDatasources mockSettigsDatasources;
  late SetttingsRepositoryImpl setttingsRepositoryImpl;

  setUp(() {
    mockSettigsDatasources = MockSettigsDatasources();
    setttingsRepositoryImpl = SetttingsRepositoryImpl(mockSettigsDatasources);
  });

  test('should call isBiometricAuthEnabled on SettigsDatasources', () async {
    when(mockSettigsDatasources.isBiometricAuthEnabled())
        .thenAnswer((realInvocation) => true);

    await setttingsRepositoryImpl.getBiometrciAuthLoginEnabledStatus();

    verify(mockSettigsDatasources.isBiometricAuthEnabled());

    verifyNoMoreInteractions(mockSettigsDatasources);
  });

  test(
      'should call toggleBiometricAuth on SettigsDatasources with ChangeBiometricAuthLoginRequestModel ',
      () async {
    var request = ChangeBiometricAuthLoginRequest(true);
    var model = ChangeBiometricAuthLoginRequestModel(true);

    when(mockSettigsDatasources.toggleBiometricAuth(model))
        .thenAnswer((realInvocation) => Future.value(Right(null)));

    await setttingsRepositoryImpl.changeBiometricAuthLogin(request);

    verify(mockSettigsDatasources.toggleBiometricAuth(any));

    verifyNoMoreInteractions(mockSettigsDatasources);
  });
}
