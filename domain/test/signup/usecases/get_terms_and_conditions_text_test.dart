import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/signup/entities/terms_and_conditions.dart';
import 'package:domain/feature/signup/repositories/user_signup_repository.dart';
import 'package:domain/feature/signup/usecases/get_terms_and_conditions_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_terms_and_conditions_text_test.mocks.dart';

@GenerateMocks([UserSignupRepository])
main() {
  late GetTermsAndConditionsText getTermsAndConditionsText;
  late MockUserSignupRepository mockUserSignupRepository;

  setUp(() {
    mockUserSignupRepository = MockUserSignupRepository();
    getTermsAndConditionsText =
        GetTermsAndConditionsText(mockUserSignupRepository);
  });
  test('', () async {
    final tAndC = 'terms and conditions';

    when(mockUserSignupRepository.getTermsAndConditionsText()).thenAnswer(
        (realInvocation) => Future.value(Right(TermsAndConditions(tAndC))));
    final result = await getTermsAndConditionsText(NoParams());

    expect(result, Right(TermsAndConditions(tAndC)));
  });
}
