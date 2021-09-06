import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/add_identity/entities/identity_data.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:domain/feature/add_identity/usecases/add_identity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_identity_test.mocks.dart';

@GenerateMocks([AddIdentityRepository])
main() {
  late AddIdentity addIdentity;
  late MockAddIdentityRepository mockAddIdentityRepository;

  setUp(() {
    mockAddIdentityRepository = MockAddIdentityRepository();
    addIdentity = AddIdentity(mockAddIdentityRepository);
  });
  test('should submit identity info to repository ', () async {
    final int idType = 1;
    final String idNumber = '123456';
    final String expiryDate = '2001-08-15 00:00:00.000';
    final String idImage1Path = 'idImage1Path';
    final String idImage2Path = 'idImage2Path';
    final String idSignaturePath = 'idSignaturePath';
    final int nationality = 2;
    final String dateOfBirth = '2001-08-15 00:00:00.000';

    final identity = IdentityData(idType, idNumber, expiryDate, idImage1Path,
        idImage2Path, idSignaturePath, nationality, dateOfBirth);

    when(mockAddIdentityRepository.addIdentity(identity)).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponse())));

    var result = await addIdentity(AddIdentityParams(
        idType: idType,
        idNumber: idNumber,
        expiryDate: expiryDate,
        idImage1Path: idImage1Path,
        idImage2Path: idImage2Path,
        idSignaturePath: idSignaturePath,
        nationality: nationality,
        dateOfBirth: dateOfBirth));

    expect(result, Right(CommonApiResponse()));
    verify(mockAddIdentityRepository.addIdentity(identity));
  });
}
