import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/add_identity/entities/id_image.dart';
import 'package:domain/feature/add_identity/entities/id_type.dart';
import 'package:domain/feature/add_identity/entities/nationality.dart';
import 'package:domain/feature/add_identity/entities/signature_image.dart';
import 'package:domain/feature/add_identity/usecases/add_identity.dart';
import 'package:domain/feature/add_identity/usecases/get_id_types.dart';
import 'package:domain/feature/add_identity/usecases/get_nationalities.dart';
import 'package:domain/feature/add_identity/usecases/pick_id_image.dart';
import 'package:domain/feature/add_identity/usecases/pick_signature.dart';
import 'package:domain/feature/add_identity/validation/date_of_birth_validation.dart';
import 'package:domain/feature/add_identity/validation/expiry_date_validation.dart';
import 'package:domain/feature/add_identity/validation/id_image_validation.dart';
import 'package:domain/feature/add_identity/validation/id_number_validation.dart';
import 'package:domain/feature/add_identity/validation/id_type_validation.dart';
import 'package:domain/feature/add_identity/validation/nationality_validation.dart';
import 'package:domain/feature/add_identity/validation/signature_image_validation.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/core/utils/validation_helper.dart';

@injectable
class AddNewIdentityPageController extends GetxController {
  late final FormGroup idenitytyForm;
  final GetIdTypes _getIdTypes;
  final GetNationalities _getNationalities;
  final PickIdImage _pickIdImage;
  final PickSignature _pickSignature;
  final AddIdentity _addIdentity;
  final AlertService _alertService;
  final NavigationService _navigationService;
  final ExpiryDateValidation expiryDateValidation = ExpiryDateValidation();
  final DateOfBirthValidation dateOfBirthValidation = DateOfBirthValidation();

  AddNewIdentityPageController(
      this._getIdTypes,
      this._getNationalities,
      this._pickIdImage,
      this._pickSignature,
      this._addIdentity,
      this._alertService,
      this._navigationService) {
    initFormFields();
  }

  Future<Either<Failure, List<IdType>>> get idTypes => _getIdTypes(NoParams());
  Future<Either<Failure, List<Nationality>>> get nationalities =>
      _getNationalities(NoParams());

  void initFormFields() {
    idenitytyForm = fb.group({
      'idType': FormControl<IdType>(
          validators: generateValidationsNonString(IdTypeValidation())),
      'idNumber': generateValidations(IdNumberValidation()),
      'expiryDate': FormControl<DateTime>(
          validators: generateValidationsNonString(
        ExpiryDateValidation(),
      )),
      'nationality': FormControl<Nationality>(
          validators: generateValidationsNonString(NationalityValidation())),
      'dob': FormControl<DateTime>(
          validators: generateValidationsNonString(DateOfBirthValidation())),
      'idImageFront': FormControl<IdImage>(
          validators: generateValidationsNonString(IdImageValidation())),
      'idImageBack': FormControl<IdImage>(
          validators: generateValidationsNonString(IdImageValidation())),
      'signature': FormControl<SignatureImage>(
          validators: generateValidationsNonString(SignatureImageValidation())),
    });
  }

  Future<void> onPickIdImageFront() async {
    selectIdImage().then((value) => value.fold((l) => null, (r) {
          idenitytyForm.controls['idImageFront']?.value = r;
        }));
  }

  Future<void> onPickIdImageBack() async {
    selectIdImage().then((value) => value.fold((l) => null, (r) {
          idenitytyForm.controls['idImageBack']?.value = r;
        }));
  }

  Future<void> onAddSignature() async {
    selectSignatureImage().then((value) => value.fold((l) => null, (r) {
          idenitytyForm.controls['signature']?.value = r;
        }));
  }

  T getFormValue<T>(String controlName) {
    return (idenitytyForm.controls[controlName] as FormControl<T>).value!;
  }

  Future<void> onConfirm() async {
    if (idenitytyForm.valid) {
      final idType = getFormValue<IdType>('idType').idTypeId;
      final idImage1 = getFormValue<IdImage>('idImageFront').imagePath;
      final idImage2 = getFormValue<IdImage>('idImageBack').imagePath;
      final signature = getFormValue<SignatureImage>('signature').signaturePath;
      final idNumber = getFormValue<String>('idNumber');
      final expiryDate = getFormValue<DateTime>('expiryDate');
      final nationality =
          getFormValue<Nationality>('nationality').nationalityId;
      final dob = getFormValue<DateTime>('dob');

      addNewIdentity(AddIdentityParams(
          idNumber: idNumber,
          dateOfBirth: dob.toString(),
          expiryDate: expiryDate.toString(),
          idImage1Path: idImage1,
          idImage2Path: idImage2,
          idSignaturePath: signature,
          idType: idType,
          nationality: nationality));
    } else
      idenitytyForm.markAllAsTouched();
  }

  void addNewIdentity(AddIdentityParams addIdentityParams) {
    _alertService.showLoader();
    _addIdentity(addIdentityParams)
        .then((value) => value.fold((l) => _alertService.hideLoader(), (r) {
              _alertService.hideLoader();
              _navigationService.navigateAndClearStackUntil(
                AppRouts.identityListPage,
                predicate: (route) =>
                    route.settings.name == AppRouts.dashboardPage,
              );
            }));
  }

  Future<Either<Failure, IdImage>> selectIdImage() async {
    return _pickIdImage(NoParams()).then((value) => value.fold((l) {
          if (l is PhotoAccessPermissionFailure)
            _showPhotoPermissionDenialAlert(l);
          return Left(l);
        }, (r) {
          return Right(r);
        }));
  }

  Future<Either<Failure, SignatureImage>> selectSignatureImage() async {
    return _pickSignature(NoParams()).then((value) => value.fold((l) {
          if (l is PhotoAccessPermissionFailure)
            _showPhotoPermissionDenialAlert(l);
          return Left(l);
        }, (r) {
          return Right(r);
        }));
  }

  _showPhotoPermissionDenialAlert(PhotoAccessPermissionFailure failure) {
    if (failure.isPermenetlyDenied)
      _alertService.showAlertSnackbar(
          title: 'Error',
          message: 'Please allow photo access permission to proceed further');
    else
      _alertService.showAlertSnackbar(
          title: 'Error', message: 'Permission Denied');
  }
}
