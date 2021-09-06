import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/core/device/local_storage.dart';
import 'package:data/core/models/add_to_local_storage_model.dart';
import 'package:data/core/models/retrieve_from_local_storage_model.dart';
import 'package:data/feature/language_selection/data_source/language_selection_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_storage_data_source_test.mocks.dart';

@GenerateMocks([LocalStorage])
main() {
  late LanguageSelectionDataSource localStorageDataSource;
  late MockLocalStorage mockLocalStorage;
  setUp(() {
    mockLocalStorage = MockLocalStorage();
    localStorageDataSource = LanguageSelectionDataSource(mockLocalStorage);
  });

  test('should get Default Languages if defult language is set', () async {
    final String testLanguage = 'en_GB';

    when(mockLocalStorage.getString(defaultLanguage))
        .thenAnswer((realInvocation) => testLanguage);
    var result = await localStorageDataSource.getDefaultLanguage();

    expect(
        result,
        Right<Failure, RetrieveFromLocalStorageModel<String>>(
            RetrieveFromLocalStorageModel<String>(testLanguage)));
    verify(mockLocalStorage.getString(defaultLanguage));
  });
  test('should return LocalStorageFailure if defult language not set',
      () async {
    when(mockLocalStorage.getString(defaultLanguage))
        .thenAnswer((realInvocation) => null);
    var result = await localStorageDataSource.getDefaultLanguage();

    expect(result, Left(LocalStorageFailure()));
    verify(mockLocalStorage.getString(defaultLanguage));
  });

  test('should save selected language to local storage', () async {
    final String testLanguage = 'en_GB';

    when(mockLocalStorage.saveString(defaultLanguage, testLanguage))
        .thenAnswer((realInvocation) => Future.value(true));
    await localStorageDataSource
        .setDefaultLanguage(AddToLocalStorageModel<String>(testLanguage));

    verify(mockLocalStorage.saveString(defaultLanguage, testLanguage));
  });
}
