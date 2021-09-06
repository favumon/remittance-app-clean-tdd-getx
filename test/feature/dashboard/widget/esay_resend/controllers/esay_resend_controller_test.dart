import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_item.dart';
import 'package:domain/feature/dashboard/easy_resend/usecases/get_easy_resend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/dashboard/widget/esay_resend/controllers/esay_resend_controller.dart';

import 'esay_resend_controller_test.mocks.dart';

@GenerateMocks([GetEasyResend, NavigationService])
main() {
  late MockGetEasyResend mockGetEasyResend;
  late MockNavigationService mockNavigationService;

  late EasyResendController easyResendController;

  setUp(() {
    mockGetEasyResend = MockGetEasyResend();
    mockNavigationService = MockNavigationService();

    easyResendController =
        EasyResendController(mockGetEasyResend, mockNavigationService);
  });

  test('should call GetEasyResend usecase when initGetEasyResend called', () {
    final params = GetEasyResendParams();

    when(mockGetEasyResend(params)).thenAnswer(
        (realInvocation) => Future.value(Right(<EasyResendItem>[])));

    easyResendController.initGetEasyResend();

    verify(mockGetEasyResend(params));
  });
}
