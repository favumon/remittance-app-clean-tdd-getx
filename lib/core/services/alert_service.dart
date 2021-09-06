import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:remittance_app/core/shared_widgets/common_loader.dart';

import '../../feature/login/widgets/account_locked_bottom_sheet.dart';
import 'navigation_service.dart';

const spinkit = SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
);

enum BottomSheetType { accountLocked, emailVerification }

@lazySingleton
class AlertService {
  final GetInterface _get;
  final NavigationService _navigationService;

  AlertService(this._get, this._navigationService);

  void showLoader() {
    if (!(_get.isDialogOpen ?? false)) {
      _get.dialog(CommonLoader());
    }
  }

  void hideLoader() {
    if (_get.isDialogOpen ?? false) {
      _navigationService.navigateBack();
    }
  }

  void showAlertSnackbar({required String title, required String message}) {
    _get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }

  void showBottomSheet(BottomSheetType bottomSheetType, {dynamic data}) {
    _get.bottomSheet(_getBottomSheet(bottomSheetType, data: data));
  }

  showBottomSheetWidget(Widget bottomSheet) {
    _get.bottomSheet(bottomSheet);
  }

  _getBottomSheet(BottomSheetType bottomSheetType, {dynamic data}) {
    switch (bottomSheetType) {
      case BottomSheetType.accountLocked:
        return AccountLockedBottomSheet();

      default:
    }
  }
}
