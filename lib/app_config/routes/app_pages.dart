import 'package:get/get.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/feature/add_identity/pages/add_new_identity_page.dart';
import 'package:remittance_app/feature/change_password/pages/change_password_page.dart';
import 'package:remittance_app/feature/country_list/pages/country_list_page.dart';
import 'package:remittance_app/feature/currency_converter/page/currency_converter_page.dart';
import 'package:remittance_app/feature/currency_converter/page/currency_list_page.dart';
import 'package:remittance_app/feature/dashboard/dashboard_page.dart';
import 'package:remittance_app/feature/identity_list/pages/identity_list_page.dart';
import 'package:remittance_app/feature/intro_slider/pages/intro_slider_page.dart';
import 'package:remittance_app/feature/language_selection/pages/change_language_page.dart';
import 'package:remittance_app/feature/notifications/pages/notifications_list_page.dart';
import 'package:remittance_app/feature/settings/pages/settings_page.dart';
import 'package:remittance_app/feature/signup/pages/terms_and_conditions_page.dart';
import 'package:remittance_app/feature/transaction/pages/transaction_cancelled_page.dart';
import 'package:remittance_app/feature/transaction/pages/transaction_completed_page.dart';
import 'package:remittance_app/feature/transaction_history/pages/pending_transaction_details_page.dart';
import 'package:remittance_app/feature/transaction_history/pages/recent_transaction_details_page.dart';
import 'package:remittance_app/feature/transaction_history/pages/transaction_history_page.dart';

//import 'package:remittance_app/feature/transaction_history/pages/transaction_history_details_page.dart';

import '../../feature/biometric_registration/pages/biometric_registration_page.dart';
import '../../feature/biometric_registration/pages/biometric_registration_success_page.dart';
import '../../feature/edit_profile/pages/edit_profile_page.dart';
import '../../feature/language_selection/pages/language_selection_page.dart';
import '../../feature/login/pages/login_page.dart';
import '../../feature/otp_verification/pages/otp_verification_page.dart';
import '../../feature/pin_registration/pages/pin_entry_pages.dart';
import '../../feature/signup/pages/signup_page.dart';
import '../../feature/splash_screen/pages/splash_screen_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRouts.initial,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRouts.languageSelectionPage,
      page: () => LanguageSelectionPage(),
    ),
    GetPage(
      name: AppRouts.loginPage,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRouts.signupPage,
      page: () => SignupPage(),
    ),
    GetPage(
      name: AppRouts.otpVerificationPage,
      page: () => OtpVerificationPage(
        otpVerificationParams: Get.arguments,
      ),
    ),
    GetPage(
      name: AppRouts.pinRegistrationPage,
      page: () => PinEntryPage(),
    ),
    GetPage(
      name: AppRouts.biometricRegistraionPage,
      page: () => BiometricRegistrationPage(),
    ),
    GetPage(
      name: AppRouts.biometricRegistraionSuccessPage,
      page: () => BiometricRegistrationSuccessPage(),
    ),
    GetPage(
      name: AppRouts.editProfilePage,
      page: () => EditProfilePage(() {}),
    ),
    GetPage(
        name: AppRouts.currencyConverterGraph,
        page: () => CurrencyConverterScreen()),
    GetPage(
        name: AppRouts.currencyCountryList, page: () => CountryListScreen()),
    GetPage(name: AppRouts.dashboardPage, page: () => DashboardScreen()),
    GetPage(
      name: AppRouts.identityListPage,
      page: () => IdentityListPage(),
    ),
    GetPage(
      name: AppRouts.addNewIdentityPage,
      page: () => AddNewIdentityPage(),
    ),
    GetPage(
      name: AppRouts.notificationListPage,
      page: () => NotificationListPage(),
    ),
    GetPage(
      name: AppRouts.introSliderPage,
      page: () => IntroSlider(),
    ),
    GetPage(
      name: AppRouts.transactionItemDetailsPage,
      page: () => RecentTransactionDetailsPage((_) {}),
    ),
    GetPage(
      name: AppRouts.pendingTransactionItemDetailsPage,
      page: () => PendingTransactionDetailsPage((_) {}),
    ),
    GetPage(
      name: AppRouts.transactionHistoryListPage,
      page: () => TransactionHistoryPage((_) {}, 0),
    ),
    GetPage(
      name: AppRouts.transactionCancelledPage,
      page: () => TransactionCancelledPage(),
    ),
    GetPage(
      name: AppRouts.transactionCompletedPage,
      page: () => TransactionCompletedPage(),
    ),
    GetPage(
      name: AppRouts.settingsPage,
      page: () => SettingsPage(),
    ),
    GetPage(
      name: AppRouts.changePasswordPage,
      page: () => ChangePasswordPage(),
    ),
    GetPage(
      name: AppRouts.termsAndConditionsPage,
      page: () => TermsAndConditionsPage(),
    ),
    GetPage(
      name: AppRouts.changeLanguage,
      page: () => ChangeLanguagePage(),
    ),
    GetPage(
      name: AppRouts.currencyList,
      page: () => CurrencyListPage(),
    ),
  ];
}
