import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/language_selection/usecases/get_default_language.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/translation/translation_service.dart';

import '../../../app_config/routes/app_routes.dart';
import '../../../core/services/navigation_service.dart';

@injectable
class SplashScreenController extends GetxController {
  final GetIt _getIt;
  final GetDefaultLanguage _getDefaultLanguage;
  final NavigationService _navigationService;
  SplashScreenController(
      this._getIt, this._getDefaultLanguage, this._navigationService);

  @override
  onReady() {
    super.onReady();

    _checkDependenciesReady();
  }

  Future<void> navigate() async {
    var language = await _getDefaultLanguage(NoParams());

    language.fold((l) => _navigateToLanguageSelectionPage(),
        (r) => _navigateToLoginPage(r.value));
  }

  _navigateToLanguageSelectionPage() {
    _navigationService.navigateAndReplace(AppRouts.languageSelectionPage);
  }

  _navigateToLoginPage(String locale) {
    TranslationService().changeLocale(locale);
    _navigationService.navigateAndReplace(AppRouts.languageSelectionPage);
  }

  Future<void> _checkDependenciesReady() async {
    await _getIt.allReady();

    navigate();
  }
}
