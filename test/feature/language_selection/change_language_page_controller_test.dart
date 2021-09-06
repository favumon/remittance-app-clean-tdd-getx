import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/entities/retrieve_from_local_storage.dart';
import 'package:domain/feature/language_selection/usecases/get_default_language.dart';
import 'package:domain/feature/language_selection/usecases/set_default_language.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/language_selection/controllers/change_language_page_controller.dart';

import 'change_language_page_controller_test.mocks.dart';

@GenerateMocks([
  SetDefaultLanguage,
  NavigationService,
  GetDefaultLanguage,
])
main() {
  late MockSetDefaultLanguage mockSetDefaultLanguage;
  late MockNavigationService mockNavigationService;
  late MockGetDefaultLanguage mockGetDefaultLanguage;

  late ChangeLanguagePageController changeLanguagePageController;

  setUp(() {
    mockSetDefaultLanguage = MockSetDefaultLanguage();
    mockNavigationService = MockNavigationService();
    mockGetDefaultLanguage = MockGetDefaultLanguage();

    changeLanguagePageController = ChangeLanguagePageController(
      mockSetDefaultLanguage,
      mockNavigationService,
      mockGetDefaultLanguage,
    );
  });

  test('should call SetDefaultLanguage usecase when language selected',
      () async {
    var selectedLanguage = 'en-US';
    var selectedLanguageParam =
        SetDefaultLanguageParams(language: selectedLanguage);

    when(mockSetDefaultLanguage(selectedLanguageParam))
        .thenAnswer((realInvocation) => Future.value(Right(true)));

    changeLanguagePageController.onLanguageSelected(selectedLanguage);

    verify(mockSetDefaultLanguage(selectedLanguageParam));
  });

  test('should navigate back when language selected', () async {
    var selectedLanguage = 'en-US';
    var selectedLanguageParam =
        SetDefaultLanguageParams(language: selectedLanguage);

    when(mockSetDefaultLanguage(selectedLanguageParam))
        .thenAnswer((realInvocation) => Future.value(Right(true)));

    changeLanguagePageController.onLanguageSelected(selectedLanguage);

    await untilCalled(mockNavigationService.navigateBack());

    verify(mockNavigationService.navigateBack());
  });

  test('should call GetDefaultLanguage when getLanguage called', () async {
    final RetrieveFromLocalStorage<String> res =
        RetrieveFromLocalStorage('English');

    when(mockGetDefaultLanguage(NoParams()))
        .thenAnswer((realInvocation) => Future.value(Right(res)));

    changeLanguagePageController.getLanguage();

    verify(mockGetDefaultLanguage(NoParams()));
  });
}
