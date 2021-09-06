import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/entities/retrieve_from_local_storage.dart';
import 'package:domain/feature/language_selection/repositories/language_selection_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetDefaultLanguage
    implements UseCase<RetrieveFromLocalStorage<String>, NoParams> {
  final LanguageSelectionRepository repository;

  GetDefaultLanguage(this.repository);

  @override
  Future<Either<Failure, RetrieveFromLocalStorage<String>>> call(
      NoParams params) async {
    return await repository.getDefaultLanguage();
  }
}
