import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/entities/retrieve_from_local_storage.dart';
import 'package:domain/feature/language_selection/usecases/get_default_language.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/di_injection/injection_container.dart';
import 'package:remittance_app/feature/splash_screen/controllers/splash_screen_controller.dart';

import 'splash_screen_controller_test.mocks.dart';

@GenerateMocks([GetDefaultLanguage, NavigationService])
main() {
  late MockGetDefaultLanguage mockGetDefaultLanguage;
  late MockNavigationService mockNavigationService;
  GetIt ggetIt = getIt;

  setUp(() {
    mockGetDefaultLanguage = MockGetDefaultLanguage();
    mockNavigationService = MockNavigationService();
  });

  test('should navigate to Login page when default language has set', () async {
    SplashScreenController splashScreenController = SplashScreenController(
        ggetIt, mockGetDefaultLanguage, mockNavigationService);

    when(mockGetDefaultLanguage(any)).thenAnswer((realInvocation) =>
        Future.value(Right(RetrieveFromLocalStorage('language'))));

    splashScreenController.navigate();

    verify(mockGetDefaultLanguage(any));

    await untilCalled(mockNavigationService
        .navigateAndReplace(AppRouts.languageSelectionPage));

    verify(mockNavigationService
        .navigateAndReplace(AppRouts.languageSelectionPage));
  });
  test(
      'should navigate to Language selection page when default language not set',
      () async {
    SplashScreenController splashScreenController = SplashScreenController(
        ggetIt, mockGetDefaultLanguage, mockNavigationService);

    when(mockGetDefaultLanguage(any)).thenAnswer(
        (realInvocation) => Future.value(Left(LocalStorageFailure())));

    splashScreenController.navigate();

    verify(mockGetDefaultLanguage(any));

    await untilCalled(mockNavigationService
        .navigateAndReplace(AppRouts.languageSelectionPage));

    verify(mockNavigationService
        .navigateAndReplace(AppRouts.languageSelectionPage));
  });
}
