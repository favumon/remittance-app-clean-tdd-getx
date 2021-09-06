import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/id_type.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:domain/feature/add_identity/usecases/get_id_types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_identity_test.mocks.dart';

@GenerateMocks([AddIdentityRepository])
main() {
  late GetIdTypes getIdTypes;
  late MockAddIdentityRepository mockAddIdentityRepository;

  setUp(() {
    mockAddIdentityRepository = MockAddIdentityRepository();
    getIdTypes = GetIdTypes(mockAddIdentityRepository);
  });
  test('should get list of IdTypes from repository', () async {
    final idTypes = [IdType('idType1', 1), IdType('idType2', 2)];

    when(mockAddIdentityRepository.getIdTypes())
        .thenAnswer((realInvocation) => Future.value(Right(idTypes)));

    var result = await getIdTypes(NoParams());

    expect(result, Right(idTypes));
    verify(mockAddIdentityRepository.getIdTypes());
  });
}
