import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/settings/models/change_biometric_auth_login_request_model.dart';
import 'package:data/feature/settings/datasources/settings_datasources.dart';
import 'package:data/core/device/local_storage.dart';
import 'package:mockito/mockito.dart';

import 'settings_datasources_test.mocks.dart';

@GenerateMocks([LocalStorage])
main() {
  late MockLocalStorage mockLocalStorage;
  late SettigsDatasources settigsDatasources;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    settigsDatasources = SettigsDatasources(mockLocalStorage);
  });

  test('should return bool from device\'s localstorage', () async {
    when(mockLocalStorage.getBool(BIOMETRIC_AUTH_ENABLED))
        .thenAnswer((realInvocation) => false);

    var result = settigsDatasources.isBiometricAuthEnabled();

    verify(mockLocalStorage.getBool(BIOMETRIC_AUTH_ENABLED));

    expect(result.runtimeType, bool);

    verifyNoMoreInteractions(mockLocalStorage);
  });

  test('should get null when a bool is stored to device\'s localstorage',
      () async {
    var request = ChangeBiometricAuthLoginRequestModel(true);

    when(mockLocalStorage.saveBool(BIOMETRIC_AUTH_ENABLED, true))
        .thenAnswer((realInvocation) => Future.value(true));

    var result = await settigsDatasources.toggleBiometricAuth(request);

    verify(mockLocalStorage.saveBool(BIOMETRIC_AUTH_ENABLED, true));

    expect(result, Right(null));

    verifyNoMoreInteractions(mockLocalStorage);
  });
}
