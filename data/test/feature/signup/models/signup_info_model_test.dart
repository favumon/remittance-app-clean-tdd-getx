import 'package:data/feature/signup/models/signup_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([])
main() {
  setUp(() {});
  test(
    'should return a JSON map containing the proper Identity details',
    () async {
      final expected = SignupInfoModel(
          email: 'email',
          firstName: 'firstName',
          lastName: 'lastName',
          middleName: 'middleName',
          otp: 'otp',
          password: 'password',
          phoneNumber: 'phoneNumber',
          username: 'username');

      var result = expected.toMap();

      final expectedMap = {
        'otp': 'otp',
        'signupData': {
          'first_name': 'firstName',
          'middle_name': 'middleName',
          'last_name': 'lastName',
          'email': 'email',
          'phone_number': 'phoneNumber',
          'username': 'username',
          'password': 'password',
        }
      };

      expect(result, expectedMap);
    },
  );
}
