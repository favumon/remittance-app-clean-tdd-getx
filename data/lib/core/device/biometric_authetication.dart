import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@lazySingleton
class BiometricAuthetication {
  final LocalAuthentication _localAuthentication;

  BiometricAuthetication(this._localAuthentication);

  Future<bool> checkBiometricsAvailable() async {
    try {
      if (await _localAuthentication.canCheckBiometrics &&
          await _localAuthentication.isDeviceSupported()) return true;
    } catch (e) {}

    return false;
  }

  Future<bool> authenticateWithBiometrics(String promptMessage) async {
    try {
      if (await checkBiometricsAvailable() &&
          await _localAuthentication.authenticate(
              localizedReason: promptMessage)) {
        return true;
      }
    } catch (e) {}

    return false;
  }
}
