import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remittance_app/app_config/translation/hi_in.dart';
import 'package:remittance_app/app_config/translation/ml_in.dart';

import 'ar_sa.dart';
import 'en_us.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static final fallbackLocale = Locale('en', 'US');

// Supported languages
  // Needs to be same order with locales
  static final langs = ['English', 'عرب', 'മലയാളം', 'हिंदी'];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('en', 'US'),
    Locale('ar', 'SA'),
    Locale('ml', 'IN'),
    Locale('hi', 'IN'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'ar_SA': ar_SA,
        'ml_IN': ml_IN,
        'hi_IN': hi_IN,
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return locale ?? Locale('en', 'US');
  }
}
