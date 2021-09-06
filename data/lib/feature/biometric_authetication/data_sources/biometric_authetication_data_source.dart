import 'package:data/core/device/biometric_authetication.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_availability_model.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_request_model.dart';
import 'package:data/feature/biometric_authetication/models/biometric_authentication_status_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BiometricAutheticationDataSource {
  final BiometricAuthetication bimetricAuthetication;

  BiometricAutheticationDataSource(this.bimetricAuthetication);

  Future<BiometricAuthenticationAvailabilityModel>
      checkBiometricsAvailable() async {
    var available = await bimetricAuthetication.checkBiometricsAvailable();
    return BiometricAuthenticationAvailabilityModel(available);
  }

  Future<BiometricAuthenticationStatusModel> authenticateWithBiometrics(
      BiometricAuthenticationRequestModel request) async {
    var isAutheticated = await bimetricAuthetication
        .authenticateWithBiometrics(request.promptMessage);
    return Future.value(BiometricAuthenticationStatusModel(isAutheticated));
  }
}
