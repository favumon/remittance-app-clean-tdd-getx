import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_availability.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_request.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_status.dart';
import 'package:domain/feature/biometric_authetication/repositories/biometric_authetication_repository.dart';
import 'package:domain/feature/biometric_authetication/usecases/autheticate_with_biometrics.dart';
import 'package:domain/feature/biometric_authetication/usecases/check_biometrics_available.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_biometrics_available_test.mocks.dart';

@GenerateMocks([BiometricAutheticationRepository])
main() {
  late AutheticateWithBiometrics autheticateWithBiometrics;
  late MockBiometricAutheticationRepository
      mockBiometricAutheticationRepository;
  setUp(() {
    mockBiometricAutheticationRepository =
        MockBiometricAutheticationRepository();
    autheticateWithBiometrics =
        AutheticateWithBiometrics(mockBiometricAutheticationRepository);
  });

  test('should return Authentication status response entity from repository',
      () async {
    final String promptMessage = 'some text';
    AutheticateWithBiometricsParams params =
        AutheticateWithBiometricsParams(promptMessage);
    BiometricAuthenticationRequest requestEntity =
        BiometricAuthenticationRequest(promptMessage);
    BiometricAuthenticationStatus responseEntity =
        BiometricAuthenticationStatus(true);

    when(mockBiometricAutheticationRepository
            .autheticateWithBiometrics(requestEntity))
        .thenAnswer((realInvocation) => Future.value(Right(responseEntity)));

    var result = await autheticateWithBiometrics(params);

    expect(result, Right(responseEntity));

    verify(mockBiometricAutheticationRepository
        .autheticateWithBiometrics(requestEntity));
    verifyNever(mockBiometricAutheticationRepository.checkBiometricAvailable());
  });
}
