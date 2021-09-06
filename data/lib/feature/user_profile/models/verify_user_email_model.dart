import 'package:domain/feature/user_profile/entities/verify_user_email_request.dart';

class VerifyUserEmailModel extends VerifyUserEmailRequest {
  final String email;

  VerifyUserEmailModel(this.email) : super(email);

  Map<String, dynamic> toMap() => {
        "email": email,
      };
}
