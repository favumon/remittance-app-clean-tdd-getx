import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/core/device/local_storage.dart';
import 'package:data/core/models/add_to_local_storage_model.dart';
import 'package:data/core/models/retrieve_from_local_storage_model.dart';
import 'package:domain/core/entities/retrieve_from_local_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LanguageSelectionDataSource {
  final LocalStorage _localStorage;

  LanguageSelectionDataSource(this._localStorage);
  Future<Either<Failure, RetrieveFromLocalStorageModel<String>>>
      getDefaultLanguage() {
    var lang = _localStorage.getString(defaultLanguage);

    return lang != null
        ? Future.value(Right(RetrieveFromLocalStorageModel<String>(lang)))
        : Future.value(Left(LocalStorageFailure()));
  }

  Future<Either<Failure, void>> setDefaultLanguage(
      AddToLocalStorageModel<String> model) async {
    var status = await _localStorage.saveString(defaultLanguage, model.value);
    return status ? Right(null) : Left(LocalStorageFailure());
  }
}
