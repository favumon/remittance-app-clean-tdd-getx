import 'dart:convert';

import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/feature/identity_list/models/identity_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([])
main() {
  setUp(() {});

  test(
    'should return a JSON map containing the proper Identity details',
    () async {
      final idType = 'Qatar ID';
      final idNumber = '4542911888';
      final expiryDate = '2020-08-27T16:28:08Z';
      var signatureUrl = 'http://dummyimage.com/169x100.png/dddddd/000000';
      var profileUrl = 'http://dummyimage.com/245x100.png/ff4444/ffffff';
      var nationality = 'Philippines';
      final expected = IdentityDetailModel(
          idNumber: idNumber,
          idType: idType,
          expiryDate: DateTime.parse(expiryDate),
          nationality: nationality,
          profileImageUrl: profileUrl,
          singatureUrl: signatureUrl);
      // final Map<String, dynamic> jsonMap =
      //     jsonDecode(apiResposeMock('identities.json'));
      final list = jsonMap(apiResposeMock('identities.json'));

      var result = list[0];

      expect(result, expected);
    },
  );
}

List<IdentityDetailModel> jsonMap(String str) => List<IdentityDetailModel>.from(
    json.decode(str).map((x) => IdentityDetailModel.fromJson(x)));
