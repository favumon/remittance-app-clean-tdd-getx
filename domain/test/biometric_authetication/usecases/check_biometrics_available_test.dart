import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_availability.dart';
import 'package:domain/feature/biometric_authetication/repositories/biometric_authetication_repository.dart';
import 'package:domain/feature/biometric_authetication/usecases/check_biometrics_available.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'check_biometrics_available_test.mocks.dart';

@GenerateMocks([BiometricAutheticationRepository])
main() {
  late CheckBiometricsAvailable checkBiometricsAvailable;
  late MockBiometricAutheticationRepository
      mockBiometricAutheticationRepository;
  setUp(() {
    mockBiometricAutheticationRepository =
        MockBiometricAutheticationRepository();
    checkBiometricsAvailable =
        CheckBiometricsAvailable(mockBiometricAutheticationRepository);
  });

  test('should return Biometric avaibility respose entity from repository',
      () async {
    NoParams params = NoParams();
    BiometricAuthenticationAvailability entity =
        BiometricAuthenticationAvailability(true);

    when(mockBiometricAutheticationRepository.checkBiometricAvailable())
        .thenAnswer((realInvocation) => Future.value(Right(entity)));

    var result = await checkBiometricsAvailable(params);

    expect(result, Right(entity));

    verify(mockBiometricAutheticationRepository.checkBiometricAvailable());
    verifyNever(
        mockBiometricAutheticationRepository.autheticateWithBiometrics(any));
  });
}
