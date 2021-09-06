import 'package:equatable/equatable.dart';

class VerifyUserEmailRequest extends Equatable {
  final String email;

  VerifyUserEmailRequest(this.email);

  @override
  List<Object?> get props => [email];
}
