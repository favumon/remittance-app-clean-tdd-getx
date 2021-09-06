import 'package:equatable/equatable.dart';

class BiometricAuthenticationStatus extends Equatable {
  final bool isAutheticated;

  BiometricAuthenticationStatus(this.isAutheticated);

  @override
  List<Object?> get props => [isAutheticated];
}
