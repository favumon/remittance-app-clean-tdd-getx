import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/biometric_authetication/data_sources/biometric_authetication_data_source.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_availability_model.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_request_model.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_status_model.dart';
import 'package:data/feature/biometric_authetication/repositories/biometric_authetication_repository_impl.dart';
import 'package:domain/feature/biometric_authetication/entities/biometric_authentication_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'biometric_authetication_repository_impl_test.mocks.dart';

@GenerateMocks([BiometricAutheticationDataSource])
main() {
  late BiometricAutheticationRepositoryImpl
      biometricAutheticationRepositoryImpl;
  late MockBiometricAutheticationDataSource
      mockBiometricAutheticationDataSource;

  setUp(() {
    mockBiometricAutheticationDataSource =
        MockBiometricAutheticationDataSource();
    biometricAutheticationRepositoryImpl = BiometricAutheticationRepositoryImpl(
        mockBiometricAutheticationDataSource);
  });

  test(
      'should return BiometricAuthenticationAvailability from BiometricAutheticationDataSource when there is biometric authetication feature available',
      () async {
    BiometricAuthenticationAvailabilityModel
        biometricAuthenticationAvailabilityModel =
        BiometricAuthenticationAvailabilityModel(true);

    when(mockBiometricAutheticationDataSource.checkBiometricsAvailable())
        .thenAnswer((realInvocation) =>
            Future.value(biometricAuthenticationAvailabilityModel));

    var result =
        await biometricAutheticationRepositoryImpl.checkBiometricAvailable();

    expect(result, Right(biometricAuthenticationAvailabilityModel));

    verify(mockBiometricAutheticationDataSource.checkBiometricsAvailable());
  });
  test(
      'should return BiometricAuthenticationFailure from BiometricAutheticationDataSource when there is biometric authetication feasture unvailable',
      () async {
    BiometricAuthenticationAvailabilityModel
        biometricAuthenticationAvailabilityModel =
        BiometricAuthenticationAvailabilityModel(false);

    when(mockBiometricAutheticationDataSource.checkBiometricsAvailable())
        .thenAnswer((realInvocation) =>
            Future.value(biometricAuthenticationAvailabilityModel));

    var result =
        await biometricAutheticationRepositoryImpl.checkBiometricAvailable();

    expect(result, Left(BiometricAuthenticationFailure()));

    verify(mockBiometricAutheticationDataSource.checkBiometricsAvailable());
  });

  test(
      'should return BiometricAuthenticationStatus from BiometricAutheticationDataSource when authetication was success',
      () async {
    BiometricAuthenticationStatusModel biometricAuthenticationStatusModel =
        BiometricAuthenticationStatusModel(true);
    final String promptMessage = 'some text';

    final request = BiometricAuthenticationRequestModel(promptMessage);

    when(mockBiometricAutheticationDataSource
            .authenticateWithBiometrics(request))
        .thenAnswer((realInvocation) =>
            Future.value(biometricAuthenticationStatusModel));

    var result =
        await biometricAutheticationRepositoryImpl.autheticateWithBiometrics(
            BiometricAuthenticationRequest(promptMessage));

    expect(result, Right(BiometricAuthenticationStatusModel(true)));

    verify(mockBiometricAutheticationDataSource
        .authenticateWithBiometrics(request));
  });

  test(
      'should return BiometricAuthenticationStatus from BiometricAutheticationDataSource when authetication was failure',
      () async {
    BiometricAuthenticationStatusModel biometricAuthenticationStatusModel =
        BiometricAuthenticationStatusModel(false);
    final String promptMessage = 'some text';

    final request = BiometricAuthenticationRequestModel(promptMessage);

    when(mockBiometricAutheticationDataSource
            .authenticateWithBiometrics(request))
        .thenAnswer((realInvocation) =>
            Future.value(biometricAuthenticationStatusModel));

    var result =
        await biometricAutheticationRepositoryImpl.autheticateWithBiometrics(
            BiometricAuthenticationRequest(promptMessage));

    expect(result, Left(BiometricAuthenticationFailure()));

    verify(mockBiometricAutheticationDataSource
        .authenticateWithBiometrics(request));
  });
}
