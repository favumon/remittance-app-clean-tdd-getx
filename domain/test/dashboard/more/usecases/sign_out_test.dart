import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:domain/feature/dashboard/more/entity/signout_request.dart';
import 'package:domain/feature/dashboard/more/usecases/sign_out.dart';
import 'package:domain/feature/dashboard/more/repositories/more_repository.dart';

import 'sign_out_test.mocks.dart';

@GenerateMocks([MoreRepository])
main() {
  late MockMoreRepository mockMoreRepository;
  late SignOut signOut;

  setUp(() {
    mockMoreRepository = MockMoreRepository();
    signOut = SignOut(mockMoreRepository);
  });

  test('should return Null from MoreRepository', () async {
    final params = SignoutRequestParams();

    when(mockMoreRepository.signOutUser(SignoutRequest()))
        .thenAnswer((realInvocation) => Future.value(Right(null)));

    var result = await signOut(params);

    expect(result, Right(null));
  });
}
