import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/nationality.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:domain/feature/add_identity/usecases/get_nationalities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_identity_test.mocks.dart';

@GenerateMocks([AddIdentityRepository])
main() {
  late GetNationalities getNationalities;
  late MockAddIdentityRepository mockAddIdentityRepository;

  setUp(() {
    mockAddIdentityRepository = MockAddIdentityRepository();
    getNationalities = GetNationalities(mockAddIdentityRepository);
  });
  test('Should get list of Nationalities from repository', () async {
    final nationalities = [
      Nationality('nation1', 1),
      Nationality('nation2', 2)
    ];

    when(mockAddIdentityRepository.getNationalities())
        .thenAnswer((realInvocation) => Future.value(Right(nationalities)));

    var result = await getNationalities(NoParams());

    expect(result, Right(nationalities));
    verify(mockAddIdentityRepository.getNationalities());
  });
}
