import 'package:equatable/equatable.dart';

class LoginAuthItem extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final int phone;
  final int remitterId;
  final String token;

  LoginAuthItem(
      {required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.remitterId,
      required this.token});

  @override
  List<Object?> get props =>
      [firstName, middleName, lastName, email, phone, remitterId, token];
}
