import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/id_image.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:domain/feature/add_identity/usecases/pick_id_image.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_identity_test.mocks.dart';

@GenerateMocks([AddIdentityRepository])
main() {
  late PickIdImage pickIdImage;
  late MockAddIdentityRepository mockAddIdentityRepository;

  setUp(() {
    mockAddIdentityRepository = MockAddIdentityRepository();
    pickIdImage = PickIdImage(mockAddIdentityRepository);
  });
  test('Should get picked image from repository', () async {
    final pickedImage = IdImage('imagePath', 'imageName');
    when(mockAddIdentityRepository.getIdImage())
        .thenAnswer((realInvocation) => Future.value(Right(pickedImage)));

    var result = await pickIdImage(NoParams());

    expect(result, Right(pickedImage));
    verify(mockAddIdentityRepository.getIdImage());
  });
}
