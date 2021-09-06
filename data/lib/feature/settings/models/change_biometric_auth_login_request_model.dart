import 'package:domain/feature/settings/entities/change_biometric_auth_login_request.dart';

class ChangeBiometricAuthLoginRequestModel
    extends ChangeBiometricAuthLoginRequest {
  final bool value;

  ChangeBiometricAuthLoginRequestModel(this.value) : super(value);
}
