import 'dart:ui';

import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/language_selection/usecases/get_default_language.dart';
import 'package:domain/feature/language_selection/usecases/set_default_language.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/app_config/translation/translation_service.dart';

import '../../../core/services/navigation_service.dart';

@injectable
class ChangeLanguagePageController extends GetxController {
  final SetDefaultLanguage setDefaultLanguage;
  final NavigationService _navigationService;
  final GetDefaultLanguage _getDefaultLanguage;

  var p = ''.obs;

  ChangeLanguagePageController(
    this.setDefaultLanguage,
    this._navigationService,
    this._getDefaultLanguage,
  );

  @override
  onInit() {
    print('oninit');
    super.onInit();

    getSelectionList();

    initPageLoad();
  }

  initPageLoad() {
    getLanguage();
  }

  getLanguage() async {
    (await _getDefaultLanguage(NoParams())).fold(
      (l) => null,
      (r) => p.value = r.value,
    );
  }

  void onLanguageSelected(String selectedLanguage) {
    TranslationService().changeLocale(selectedLanguage);

    setDefaultLanguage(SetDefaultLanguageParams(language: selectedLanguage));

    _navigationService.navigateBack();
  }

  List<String> selectionModelList = [];

  getSelectionList() {
    selectionModelList.clear();
    selectionModelList.addAll((TranslationService.langs));
  }

  Locale? get locale => TranslationService.locale;
}
