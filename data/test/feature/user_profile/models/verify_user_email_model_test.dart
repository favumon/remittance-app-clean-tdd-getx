import 'package:data/feature/user_profile/models/verify_user_email_model.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test(
    'should return a JSON map containing the proper data',
    () async {
      final email = 'test@test.com';
      final model = VerifyUserEmailModel(email);
      final result = model.toMap();
      final expectedMap = {
        "email": email,
      };
      expect(result, expectedMap);
    },
  );
}
