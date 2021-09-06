import 'package:data/core/device/biometric_authetication.dart';
import 'package:data/feature/biometric_authetication/data_sources/biometric_authetication_data_source.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_availability_model.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_request_model.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_status_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'biometric_authetication_data_source_test.mocks.dart';

@GenerateMocks([BiometricAuthetication])
main() {
  late BiometricAutheticationDataSource biometricAutheticationDataSource;
  late MockBiometricAuthetication mockBiometricAuthetication;

  setUp(() {
    mockBiometricAuthetication = MockBiometricAuthetication();
    biometricAutheticationDataSource =
        BiometricAutheticationDataSource(mockBiometricAuthetication);
  });

  test(
      'should return BiometricAuthenticationAvailability from device\'s Biometric',
      () async {
    when(mockBiometricAuthetication.checkBiometricsAvailable())
        .thenAnswer((realInvocation) => Future.value(true));
    var result =
        await biometricAutheticationDataSource.checkBiometricsAvailable();

    verify(mockBiometricAuthetication.checkBiometricsAvailable());

    expect(result, BiometricAuthenticationAvailabilityModel(true));
    verifyNoMoreInteractions(mockBiometricAuthetication);
  });
  test('should return BiometricAuthenticationStatus from device\'s Biometric',
      () async {
    final String promptMessage = 'some test';
    final BiometricAuthenticationStatusModel
        biometricAuthenticationStatusModel =
        BiometricAuthenticationStatusModel(true);
    when(mockBiometricAuthetication.authenticateWithBiometrics(promptMessage))
        .thenAnswer((realInvocation) => Future.value(true));
    var result =
        await biometricAutheticationDataSource.authenticateWithBiometrics(
            BiometricAuthenticationRequestModel(promptMessage));

    verify(
        mockBiometricAuthetication.authenticateWithBiometrics(promptMessage));

    expect(result, biometricAuthenticationStatusModel);

    verifyNoMoreInteractions(mockBiometricAuthetication);
  });
}
