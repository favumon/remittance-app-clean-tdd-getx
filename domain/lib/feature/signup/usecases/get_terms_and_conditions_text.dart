import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/signup/entities/terms_and_conditions.dart';
import 'package:domain/feature/signup/repositories/user_signup_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetTermsAndConditionsText
    implements UseCase<TermsAndConditions, NoParams> {
  final UserSignupRepository repository;

  GetTermsAndConditionsText(this.repository);

  @override
  Future<Either<Failure, TermsAndConditions>> call(NoParams params) async {
    return await repository.getTermsAndConditionsText();
  }
}
