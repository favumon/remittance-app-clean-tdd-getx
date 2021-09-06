import 'package:data/feature/user_profile/models/update_user_info_model.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test(
    'should return a JSON map containing the proper data',
    () async {
      final mobileNumber = '123456789';
      final model = UpdateUserInfoModel(mobileNumber);
      final result = model.toMap();
      final expectedMap = {
        "phoneNumber": mobileNumber,
      };
      expect(result, expectedMap);
    },
  );
}
