import 'package:equatable/equatable.dart';

class ChangeBiometricAuthLoginRequest extends Equatable {
  final bool value;

  ChangeBiometricAuthLoginRequest(this.value);
  @override
  List<Object?> get props => [value];
}
