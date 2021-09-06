import 'package:equatable/equatable.dart';

class BiometricAuthenticationAvailability extends Equatable {
  final bool isBiometricAvailable;

  BiometricAuthenticationAvailability(this.isBiometricAvailable);

  @override
  List<Object?> get props => [isBiometricAvailable];
}
