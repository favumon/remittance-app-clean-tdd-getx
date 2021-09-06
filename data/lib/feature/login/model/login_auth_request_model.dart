import 'package:domain/feature/login/entities/login_auth_request.dart';

class LoginAuthRequestModel extends LoginAuthRequest {
  final String userName;
  final String password;
  LoginAuthRequestModel({required this.userName, required this.password})
      : super(userName: userName, password: password);

  Map<String, dynamic> toJson() {
    return {'user_name': userName, 'password': password};
  }
}
