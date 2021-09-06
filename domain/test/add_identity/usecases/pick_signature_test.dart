import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/signature_image.dart';
import 'package:domain/feature/add_identity/repositories/add_identity_repository.dart';
import 'package:domain/feature/add_identity/usecases/pick_signature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_identity_test.mocks.dart';

@GenerateMocks([AddIdentityRepository])
main() {
  late PickSignature pickSignature;
  late MockAddIdentityRepository mockAddIdentityRepository;

  setUp(() {
    mockAddIdentityRepository = MockAddIdentityRepository();
    pickSignature = PickSignature(mockAddIdentityRepository);
  });
  test('Should get picked signature image from repository', () async {
    final pickedImage = SignatureImage('imagePath', 'imageName');
    when(mockAddIdentityRepository.getSignatureImage())
        .thenAnswer((realInvocation) => Future.value(Right(pickedImage)));

    var result = await pickSignature(NoParams());

    expect(result, Right(pickedImage));
    verify(mockAddIdentityRepository.getSignatureImage());
  });
}
