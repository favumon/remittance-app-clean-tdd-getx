import 'package:domain/feature/signup/entities/signup_info.dart';

class SignupInfoModel extends SignupInfo {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String username;
  final String password;
  final String otp;
  SignupInfoModel(
      {required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.username,
      required this.password,
      required this.otp})
      : super(
            email: email,
            firstName: firstName,
            lastName: lastName,
            middleName: middleName,
            password: password,
            phoneNumber: phoneNumber,
            username: username);

  Map<String, dynamic> toMap() => {
        'otp': otp,
        'signupData': {
          'first_name': firstName,
          'middle_name': middleName,
          'last_name': lastName,
          'email': email,
          'phone_number': phoneNumber,
          'username': username,
          'password': password,
        }
      };
}
