import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/identity_list/entities/identity_details.dart';
import 'package:domain/feature/identity_list/repositories/identity_list_repository.dart';
import 'package:domain/feature/identity_list/usecases/get_identities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_identities_test.mocks.dart';

@GenerateMocks([
  IdentityListRepository,
])
main() {
  late MockIdentityListRepository mockIdentityListRepository;
  late GetIdentities getIdentities;

  setUp(() {
    mockIdentityListRepository = MockIdentityListRepository();
    getIdentities = GetIdentities(mockIdentityListRepository);
  });
  test('Should get Idetities from repository', () async {
    final idType = 'Qatar ID';
    final idNumber = '123456789';
    final expiryDate = DateTime.now();
    var signatureUrl = 'www.someurl.com/image.png';
    var profileUrl = 'www.someurl.com/image.png';
    var nationality = 'Nation';
    final identityData1 = IdentityDetails(
        idType: idType,
        idNumber: idNumber,
        expiryDate: expiryDate,
        nationality: nationality,
        profileImageUrl: profileUrl,
        signatureUrl: signatureUrl);
    final List<IdentityDetails> identities = [identityData1];
    when(mockIdentityListRepository.getIdentities())
        .thenAnswer((realInvocation) => Future.value(Right(identities)));
    var result = await getIdentities(NoParams());

    expect(result, Right(identities));
  });
}
