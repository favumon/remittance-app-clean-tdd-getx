import 'package:equatable/equatable.dart';

class LoginAuthRequest extends Equatable {
  final String userName;
  final String password;
  LoginAuthRequest({required this.userName, required this.password});

  @override
  List<Object?> get props => [userName, password];
}
