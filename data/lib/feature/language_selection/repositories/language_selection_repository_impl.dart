import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/core/device/local_storage.dart';
import 'package:data/core/models/add_to_local_storage_model.dart';
import 'package:data/core/models/retrieve_from_local_storage_model.dart';
import 'package:domain/core/entities/add_to_local_storage.dart';
import 'package:domain/core/entities/retrieve_from_local_storage.dart';
import 'package:domain/feature/language_selection/entities/language_selection.dart';
import 'package:domain/feature/language_selection/repositories/language_selection_repository.dart';
import 'package:injectable/injectable.dart';

import '../data_source/language_selection_data_source.dart';

@LazySingleton(as: LanguageSelectionRepository)
class LanguageSelectionRepositoryImpl extends LanguageSelectionRepository {
  final LanguageSelectionDataSource localStorageDataSource;

  LanguageSelectionRepositoryImpl(this.localStorageDataSource);

  Future<Either<Failure, RetrieveFromLocalStorage<String>>>
      getDefaultLanguage() async {
    return await localStorageDataSource.getDefaultLanguage();
  }

  @override
  Future<Either<Failure, void>> setDefaultLanguage(
      AddToLocalStorage<String> params) async {
    return await localStorageDataSource
        .setDefaultLanguage(AddToLocalStorageModel(params.value));
  }

  @override
  Future<Either<Failure, LanguageSelection>> getListOfLangauge() {
    // TODO: implement getListOfLangauge
    throw UnimplementedError();
  }
}
