import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/add_identity/entities/id_image.dart';
import 'package:domain/feature/add_identity/entities/signature_image.dart';
import 'package:domain/feature/add_identity/usecases/add_identity.dart';
import 'package:domain/feature/add_identity/usecases/get_id_types.dart';
import 'package:domain/feature/add_identity/usecases/get_nationalities.dart';
import 'package:domain/feature/add_identity/usecases/pick_id_image.dart';
import 'package:domain/feature/add_identity/usecases/pick_signature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/add_identity/controllers/add_new_identity_page_controller.dart';

import 'add_new_identity_page_controller_test.mocks.dart';

@GenerateMocks([
  GetIdTypes,
  GetNationalities,
  PickIdImage,
  PickSignature,
  AddIdentity,
  AlertService,
  NavigationService
])
main() {
  late MockGetIdTypes mockGetIdTypes;
  late MockGetNationalities mockGetNationalities;
  late MockPickIdImage mockPickIdImage;
  late MockPickSignature mockPickSignature;
  late MockAddIdentity mockAddIdentity;
  late MockAlertService mockAlertService;
  late MockNavigationService mockNavigationService;
  late AddNewIdentityPageController addNewIdentityPageController;
  setUp(() {
    mockGetIdTypes = MockGetIdTypes();
    mockGetNationalities = MockGetNationalities();
    mockPickIdImage = MockPickIdImage();
    mockPickSignature = MockPickSignature();
    mockAddIdentity = MockAddIdentity();
    mockAlertService = MockAlertService();
    mockNavigationService = MockNavigationService();

    addNewIdentityPageController = AddNewIdentityPageController(
        mockGetIdTypes,
        mockGetNationalities,
        mockPickIdImage,
        mockPickSignature,
        mockAddIdentity,
        mockAlertService,
        mockNavigationService);
  });
  test('Should call PickSignature usecase for selectiong Signature', () async {
    SignatureImage signatureImage = SignatureImage('imagePath', 'imageName');
    when(mockPickSignature(NoParams()))
        .thenAnswer((realInvocation) => Future.value(Right(signatureImage)));
    var result = await addNewIdentityPageController.selectSignatureImage();
    expect(result, Right(signatureImage));
    verify(mockPickSignature(NoParams()));
  });
  test('Should call PickIdImage usecase for selectiong ID Image', () async {
    IdImage idImage = IdImage('imagePath', 'imageName');
    when(mockPickIdImage(NoParams()))
        .thenAnswer((realInvocation) => Future.value(Right(idImage)));
    var result = await addNewIdentityPageController.selectIdImage();
    expect(result, Right(idImage));
    verify(mockPickIdImage(NoParams()));
  });
  test(
      'Should show loader while submitting Identity form and should hide incase of success ',
      () async {
    final int idType = 1;
    final String idNumber = '123456';
    final String expiryDate = '2001-08-15 00:00:00.000';
    final String idImage1Path = 'idImage1Path';
    final String idImage2Path = 'idImage2Path';
    final String idSignaturePath = 'idSignaturePath';
    final int nationality = 2;
    final String dateOfBirth = '2001-08-15 00:00:00.000';

    final param = AddIdentityParams(
        idType: idType,
        idNumber: idNumber,
        expiryDate: expiryDate,
        idImage1Path: idImage1Path,
        idImage2Path: idImage2Path,
        idSignaturePath: idSignaturePath,
        nationality: nationality,
        dateOfBirth: dateOfBirth);

    when(mockAddIdentity(param)).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponse())));
    addNewIdentityPageController.addNewIdentity(param);
    await untilCalled(mockAlertService.hideLoader());
    verifyInOrder(
        [mockAlertService.showLoader(), mockAlertService.hideLoader()]);
  });
  test(
      'Should show loader while submitting Identity form and should hide incase of failure ',
      () async {
    final int idType = 1;
    final String idNumber = '123456';
    final String expiryDate = '2001-08-15 00:00:00.000';
    final String idImage1Path = 'idImage1Path';
    final String idImage2Path = 'idImage2Path';
    final String idSignaturePath = 'idSignaturePath';
    final int nationality = 2;
    final String dateOfBirth = '2001-08-15 00:00:00.000';

    final param = AddIdentityParams(
        idType: idType,
        idNumber: idNumber,
        expiryDate: expiryDate,
        idImage1Path: idImage1Path,
        idImage2Path: idImage2Path,
        idSignaturePath: idSignaturePath,
        nationality: nationality,
        dateOfBirth: dateOfBirth);

    when(mockAddIdentity(param))
        .thenAnswer((realInvocation) => Future.value(Left(ServerFailure())));
    addNewIdentityPageController.addNewIdentity(param);
    await untilCalled(mockAlertService.hideLoader());
    verifyInOrder(
        [mockAlertService.showLoader(), mockAlertService.hideLoader()]);
  });
  test('Should redirect to Id List page on successfull form submission',
      () async {
    final int idType = 1;
    final String idNumber = '123456';
    final String expiryDate = '2001-08-15 00:00:00.000';
    final String idImage1Path = 'idImage1Path';
    final String idImage2Path = 'idImage2Path';
    final String idSignaturePath = 'idSignaturePath';
    final int nationality = 2;
    final String dateOfBirth = '2001-08-15 00:00:00.000';

    final param = AddIdentityParams(
        idType: idType,
        idNumber: idNumber,
        expiryDate: expiryDate,
        idImage1Path: idImage1Path,
        idImage2Path: idImage2Path,
        idSignaturePath: idSignaturePath,
        nationality: nationality,
        dateOfBirth: dateOfBirth);

    when(mockAddIdentity(param)).thenAnswer(
        (realInvocation) => Future.value(Right(CommonApiResponse())));
    addNewIdentityPageController.addNewIdentity(param);
    await untilCalled(mockNavigationService.navigateAndClearStackUntil(
        AppRouts.identityListPage,
        predicate: anyNamed('predicate')));

    verify(mockNavigationService.navigateAndClearStackUntil(
      AppRouts.identityListPage,
      predicate: anyNamed('predicate'),
    ));
  });
}
