import 'dart:convert';

import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/feature/user_profile/models/user_info_model.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  test(
    'should return a valid user model when user map is valid',
    () async {
      final map = jsonDecode(apiResposeMock('user_info.json'));
      final model = UserInfoModel(
          firstName: 'Darrel',
          email: 'dforryan0@usnews.com',
          lastName: 'Forryan',
          middleName: 'M',
          phoneNumber: '3726624574',
          profileImage:
              'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=250&w=760');
      final result = UserInfoModel.fromMap(map);

      expect(result, model);
    },
  );
}
