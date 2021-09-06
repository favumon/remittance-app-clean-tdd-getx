import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/user_profile/entities/user_info.dart';
import 'package:domain/feature/user_profile/usecases/update_user_info.dart';
import 'package:domain/feature/user_profile/usecases/verify_user_email.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/feature/edit_profile/controllers/edit_profile_page_controller.dart';

import 'edit_profile_page_controller_test.mocks.dart';

@GenerateMocks([UserInfo, UpdateUserInfo, AlertService, VerifyUserEmail])
main() {
  late EditProfilePageController editProfilePageController;
  late MockAlertService mockAlertService;
  late MockUserInfo mockUserInfo;
  late MockUpdateUserInfo mockUpdateUserInfo;
  late MockVerifyUserEmail mockVerifyUserEmail;

  setUp(() {
    mockAlertService = MockAlertService();
    mockVerifyUserEmail = MockVerifyUserEmail();
    mockUpdateUserInfo = MockUpdateUserInfo();
    mockUserInfo = MockUserInfo();

    editProfilePageController = EditProfilePageController(mockUserInfo,
        mockUpdateUserInfo, mockAlertService, mockVerifyUserEmail);
  });
  test(
      'should call UpdateUserInfo usecase for the mobile number provided when form is valid',
      () async {
    final mobileNo = '123456789';
    when(mockUpdateUserInfo(UpdateUserInfoParams(mobileNo))).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponse())));

    await editProfilePageController.updatePhoneNumber(true, mobileNo);

    verify(mockUpdateUserInfo(UpdateUserInfoParams(mobileNo)));
  });
  test('should not call UpdateUserInfo usecase when form is invalid', () async {
    final mobileNo = '123456789';
    when(mockUpdateUserInfo(UpdateUserInfoParams(mobileNo))).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponse())));

    await editProfilePageController.updatePhoneNumber(false, mobileNo);

    verifyZeroInteractions(mockUpdateUserInfo);
  });
  test('should show loader while updating user profile', () async {
    final mobileNo = '123456789';
    when(mockUpdateUserInfo(UpdateUserInfoParams(mobileNo))).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponse())));

    await editProfilePageController.updatePhoneNumber(true, mobileNo);

    verify(mockAlertService.showLoader());
  });
  test('should hide loader after updating user profile', () async {
    final mobileNo = '123456789';
    when(mockUpdateUserInfo(UpdateUserInfoParams(mobileNo))).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponse())));

    await editProfilePageController.updatePhoneNumber(true, mobileNo);

    verifyInOrder(
        [mockAlertService.showLoader(), mockAlertService.hideLoader()]);
  });
  test('should show snackbar when profile update was success', () async {
    final mobileNo = '123456789';
    when(mockUpdateUserInfo(UpdateUserInfoParams(mobileNo))).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponse())));

    await editProfilePageController.updatePhoneNumber(true, mobileNo);

    verify(mockAlertService.showAlertSnackbar(
        title: anyNamed('title'), message: anyNamed('message')));
  });
}
