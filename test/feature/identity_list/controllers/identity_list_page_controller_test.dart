import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/identity_list/entities/identity_details.dart';
import 'package:domain/feature/identity_list/usecases/get_identities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/identity_list/controllers/identity_list_page_controller.dart';

import 'identity_list_page_controller_test.mocks.dart';

@GenerateMocks([GetIdentities, NavigationService])
main() {
  late MockNavigationService mockNavigationService;
  late MockGetIdentities mockGetIdentities;
  late IdentityListPageController identityListPageController;

  setUp(() {
    mockNavigationService = MockNavigationService();
    mockGetIdentities = MockGetIdentities();
    identityListPageController =
        IdentityListPageController(mockGetIdentities, mockNavigationService);
  });
  test('Should get Identities from GetIdentities usecase', () async {
    final idType = 'Qatar ID';
    final idNumber = '4542911888';
    final expiryDate = '2020-08-27T16:28:08Z';
    var signatureUrl = 'http://dummyimage.com/169x100.png/dddddd/000000';
    var profileUrl = 'http://dummyimage.com/245x100.png/ff4444/ffffff';
    var nationality = 'Philippines';
    final expected = [
      IdentityDetails(
          idNumber: idNumber,
          idType: idType,
          expiryDate: DateTime.parse(expiryDate),
          nationality: nationality,
          profileImageUrl: profileUrl,
          signatureUrl: signatureUrl)
    ];
    when(mockGetIdentities(NoParams()))
        .thenAnswer((realInvocation) => Future.value(Right(expected)));
    var result = await identityListPageController.fetchIdentitiesFromApi();

    expect(result, Right(expected));
  });
}
