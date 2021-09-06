import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/entities/add_to_local_storage.dart';
import 'package:domain/feature/language_selection/repositories/language_selection_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SetDefaultLanguage implements UseCase<void, SetDefaultLanguageParams> {
  final LanguageSelectionRepository repository;

  SetDefaultLanguage(this.repository);

  @override
  Future<Either<Failure, void>> call(SetDefaultLanguageParams params) async {
    return await repository
        .setDefaultLanguage(AddToLocalStorage<String>(params.language));
  }
}

class SetDefaultLanguageParams extends Equatable {
  final String language;

  SetDefaultLanguageParams({required this.language});

  @override
  List<Object> get props => [language];
}
