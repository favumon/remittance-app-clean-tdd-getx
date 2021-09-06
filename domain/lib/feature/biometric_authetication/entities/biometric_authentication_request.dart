import 'package:equatable/equatable.dart';

class BiometricAuthenticationRequest extends Equatable {
  final String promptMessage;

  BiometricAuthenticationRequest(this.promptMessage);

  @override
  List<Object?> get props => [promptMessage];
}
