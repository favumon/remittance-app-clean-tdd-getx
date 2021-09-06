import 'package:domain/feature/app_settings/entities/app_settings.dart';
import 'package:domain/feature/language_selection/usecases/set_default_language.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/translation/translation_service.dart';

import '../../../app_config/routes/app_routes.dart';
import '../../../core/services/navigation_service.dart';

@injectable
class LanguageSelectionPageController extends GetxController {
  final SetDefaultLanguage setDefaultLanguage;
  final NavigationService _navigationService;
  final AppSettings appSettings;

  LanguageSelectionPageController(
    this.setDefaultLanguage,
    this._navigationService,
    this.appSettings,
  );
  void onLanguageSelected(String selectedLanguage) {
    TranslationService().changeLocale(selectedLanguage);

    setDefaultLanguage(SetDefaultLanguageParams(language: selectedLanguage));
    _navigationService.navigateAndReplace(AppRouts.introSliderPage);
  }

  List<String> selectionModelList = [];

  getSelectionList() {
    selectionModelList.addAll((TranslationService.langs));
  }
}
