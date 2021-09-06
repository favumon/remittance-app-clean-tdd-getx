import 'package:domain/feature/login/entities/login_auth_item.dart';

class LoginAuthModel extends LoginAuthItem {
  String firstName;
  String middleName;
  String lastName;
  String email;
  int phone;
  int remitterId;
  String token;
  LoginAuthModel(
      {required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.remitterId,
      required this.token})
      : super(
            firstName: firstName,
            middleName: middleName,
            lastName: lastName,
            email: email,
            phone: phone,
            remitterId: remitterId,
            token: token);

  factory LoginAuthModel.fromMap(Map<String, dynamic> json) {
    return LoginAuthModel(
      firstName: json['first_name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      remitterId: json['remitter_id'],
      token: json['token'],
    );
  }
}
