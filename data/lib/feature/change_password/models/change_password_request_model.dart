import 'package:domain/feature/change_password/entities/change_password_request.dart';

class ChangePasswordRequestModel extends ChangePasswordRequest {
  final String curPwd;
  final String newPwd;

  ChangePasswordRequestModel({required this.curPwd, required this.newPwd})
      : super(
          currentPassword: curPwd,
          newPassword: newPwd,
        );

  Map<String, dynamic> toMap() {
    return {
      'current_password': curPwd,
      'new_password': newPwd,
    };
  }
}
