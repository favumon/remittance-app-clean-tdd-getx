import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/core/models/add_to_local_storage_model.dart';
import 'package:data/core/models/retrieve_from_local_storage_model.dart';
import 'package:data/feature/language_selection/data_source/language_selection_data_source.dart';
import 'package:data/feature/language_selection/repositories/language_selection_repository_impl.dart';
import 'package:domain/core/entities/add_to_local_storage.dart';
import 'package:domain/feature/language_selection/repositories/language_selection_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'language_selection_repository_impl_test.mocks.dart';

@GenerateMocks([LanguageSelectionDataSource])
main() {
  late MockLanguageSelectionDataSource mockLocalStorageDataSource;
  late LanguageSelectionRepository localStorageRepository;
  setUp(() {
    mockLocalStorageDataSource = MockLanguageSelectionDataSource();
    localStorageRepository =
        LanguageSelectionRepositoryImpl(mockLocalStorageDataSource);
  });

  test('should get Default Languages if defult language is set', () async {
    final language = 'en_US';
    RetrieveFromLocalStorageModel<String> model =
        RetrieveFromLocalStorageModel(language);

    when(mockLocalStorageDataSource.getDefaultLanguage())
        .thenAnswer((realInvocation) => Future.value(Right(model)));

    var result = await localStorageRepository.getDefaultLanguage();

    expect(result, Right(model));

    verify(mockLocalStorageDataSource.getDefaultLanguage());
    verifyNoMoreInteractions(mockLocalStorageDataSource);
  });
  test('should return LocalStorageFailure if defult language is not set',
      () async {
    when(mockLocalStorageDataSource.getDefaultLanguage()).thenAnswer(
        (realInvocation) => Future.value(Left(LocalStorageFailure())));

    var result = await localStorageRepository.getDefaultLanguage();

    expect(result, left(LocalStorageFailure()));

    verify(mockLocalStorageDataSource.getDefaultLanguage());
    verifyNoMoreInteractions(mockLocalStorageDataSource);
  });

  test(
      'should call setDefaultLanguage on LanguageSelectionDataSource with language value',
      () async {
    final language = 'en_US';
    AddToLocalStorageModel<String> model = AddToLocalStorageModel(language);

    when(mockLocalStorageDataSource.setDefaultLanguage(model))
        .thenAnswer((realInvocation) => Future.value(Right(null)));

    await localStorageRepository
        .setDefaultLanguage(AddToLocalStorage(language));

    verify(mockLocalStorageDataSource.setDefaultLanguage(model));
    verifyNoMoreInteractions(mockLocalStorageDataSource);
  });
}
