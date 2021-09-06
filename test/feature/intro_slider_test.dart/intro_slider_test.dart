import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/intro_slider/controllers/intro_slider_page_controller.dart';

import 'intro_slider_test.mocks.dart';

@GenerateMocks([NavigationService])
main() {
  late MockNavigationService mockNavigationService;
  late IntroSliderPageController introSliderPageController;

  setUp(() {
    mockNavigationService = MockNavigationService();
    introSliderPageController =
        IntroSliderPageController(mockNavigationService);
  });

  test('should navigate to registerPage when navigateToRegister called', () {
    introSliderPageController.navigateToRegister();

    verify(mockNavigationService.navigateAndReplace(AppRouts.signupPage));
  });

  test('should navigate to loginpage when navigateToLogin called', () {
    introSliderPageController.navigateToSignIn();

    verify(mockNavigationService.navigateAndReplace(AppRouts.loginPage));
  });
}
