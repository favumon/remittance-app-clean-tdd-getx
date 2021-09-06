import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/entities/add_to_local_storage.dart';
import 'package:domain/core/entities/retrieve_from_local_storage.dart';

abstract class LanguageSelectionRepository {
  Future<Either<Failure, RetrieveFromLocalStorage<String>>>
      getDefaultLanguage();
  Future<Either<Failure, void>> setDefaultLanguage(
      AddToLocalStorage<String> params);
}
