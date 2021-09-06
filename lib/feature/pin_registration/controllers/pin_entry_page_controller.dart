import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/biometric_authetication/usecases/autheticate_with_biometrics.dart';
import 'package:domain/feature/biometric_authetication/usecases/check_biometrics_available.dart';
import 'package:domain/feature/pin_registration/usecases/register_pin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/core/services/alert_service.dart';

import '../../../app_config/routes/app_routes.dart';
import '../../../core/services/navigation_service.dart';

enum PinEntryMode { registration, confirmation }

@injectable
class PinEntryPageController extends GetxController {
  final RegisterPin registerPin;
  final CheckBiometricsAvailable checkBiometricsAvailable;
  final AutheticateWithBiometrics autheticateWithBiometrics;
  final NavigationService navigationService;
  final AlertService alertService;

  TextEditingController pinController = TextEditingController();

  FocusNode focusNode = FocusNode();
  PinEntryPageController(
      this.registerPin,
      this.navigationService,
      this.checkBiometricsAvailable,
      this.autheticateWithBiometrics,
      this.alertService);
  PinEntryMode _pinEntryMode = PinEntryMode.registration;
  String? pin;

  String get pageTitle => _pinEntryMode == PinEntryMode.registration
      ? 'register_pin'.tr
      : 'confirm_pin'.tr;
  String get buttonText =>
      _pinEntryMode == PinEntryMode.registration ? 'register'.tr : 'confirm'.tr;

  get isConfirmation => _pinEntryMode == PinEntryMode.confirmation;

  // Future<void> onPinSubmit() async {
  //                               focusNode.unfocus();

  //   if (isConfirmation) {
  //     (await checkBiometricsAvailable(NoParams()))
  //         .fold((l) => null, (r) async {});
  //   } else {
  //     _pinEntryMode = PinEntryMode.confirmation;
  //     pinController.clear();
  //   }

  //   update();
  // }

  void onBack() {
    _pinEntryMode = PinEntryMode.registration;
    update();
  }

  Future<void> onPinComplete(String value) async {
    focusNode.unfocus();

    if (isConfirmation) {
      if (pin != value) {
        alertService.showAlertSnackbar(
            title: 'pin_mismatch'.tr, message: 'pin_confirm_pin_not_match');
        pinController.clear();
      } else {
        registerPin(RegisterPinParams(pin: pin!));

        final biometricStatus = await checkBiometricsAvailable(NoParams());

        biometricStatus.fold((l) => null, (r) {
          if (r.isBiometricAvailable) {
            navigationService
                .navigateAndReplace(AppRouts.biometricRegistraionPage);
          }
        });
      }
    } else {
      pin = value;
      pinController.clear();
      _pinEntryMode = PinEntryMode.confirmation;
      update();
    }
  }

  @override
  void onClose() {
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
