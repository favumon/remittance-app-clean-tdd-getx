import 'package:equatable/equatable.dart';

class SignupInfo extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String username;
  final String password;

  SignupInfo(
      {required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.username,
      required this.password});

  @override
  List<Object?> get props => [
        this.firstName,
        this.middleName,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.username,
        this.password
      ];
}
