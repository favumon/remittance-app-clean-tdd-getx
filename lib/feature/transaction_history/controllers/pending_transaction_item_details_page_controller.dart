import 'dart:async';

import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item_details_.dart';
import 'package:domain/feature/transaction_history/entities/reference_image.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:domain/feature/transaction_history/usecases/cancel_transaction.dart';
import 'package:domain/feature/transaction_history/usecases/complete_transaction.dart';
import 'package:domain/feature/transaction_history/usecases/get_pending_transaction_details.dart';
import 'package:domain/feature/transaction_history/usecases/pick_reference_image.dart';
import 'package:domain/feature/transaction_history/validations/reference_image_validation.dart';
import 'package:domain/feature/transaction_history/validations/transaction_bank_reference_number.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:remittance_app/app_config/assets/images/images.dart';
import 'package:remittance_app/app_config/routes/app_routes.dart';
import 'package:remittance_app/core/services/alert_service.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/core/utils/validation_helper.dart';

@injectable
class PendingTrasactionItemDetailsPageController extends GetxController {
  final AlertService _alertService;
  final NavigationService _navigationService;
  final GetPendingTransactionDetails _getPendingTransactionDetails;
  final CancelTransaction _cancelTransaction;
  final CompleteTransaction _completeTransaction;
  final PickReferenceImage _pickRefrenceImage;

  var busy = false.obs;
  var expired = true.obs;
  var time = '00:00:00'.obs;

  late PendingTransactionItemDetails pendingTransactionItemDetails;
  late final FormGroup completeTxnForm;
  late final FormGroup cancelTxnForm;
  late Timer _timer;

  final referenceNumberValidation = TransactionBankReferenceNumberValidation();

  PendingTrasactionItemDetailsPageController(
    this._alertService,
    this._navigationService,
    this._getPendingTransactionDetails,
    this._cancelTransaction,
    this._completeTransaction,
    this._pickRefrenceImage,
  ) {
    initCompleteTxnFormFields();
    initCancelTxnFormFields();
  }

  @override
  onInit() {
    super.onInit();
    var refId = _navigationService.get.arguments;
    getPendingTransactionDetails(refId);
  }

  @override
  void onClose() {
    print('closed');
    _timer.cancel();
    super.onClose();
  }

  void initCompleteTxnFormFields() {
    completeTxnForm = fb.group({
      'reference_no': generateValidations(referenceNumberValidation),
      'reference_image': FormControl<ReferenceImage>(
        validators: generateValidationsNonString(ReferenceImageValidation()),
      )
    });
  }

  void initCancelTxnFormFields() {
    cancelTxnForm = fb.group({
      'reason': '',
    });
  }

  onPickReferenceImage() async {
    selectReferenceImage().then((value) => value.fold((l) => null, (r) {
          completeTxnForm.controls['reference_image']?.value = r;
        }));
  }

  Future<Either<Failure, ReferenceImage>> selectReferenceImage() async {
    return await _pickRefrenceImage(NoParams());
  }

  getPendingTransactionDetails(int refId) async {
    busy.value = true;
    var res = await _getPendingTransactionDetails(
        GetPendingTransactionDetailsParams(refId));
    busy.value = false;

    res.fold(
      (l) =>
          _alertService.showAlertSnackbar(title: '', message: l.message ?? ''),
      (r) {
        pendingTransactionItemDetails = r;
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          time.value = pendingTransactionItemDetails.remainingTime;
          expired.value = pendingTransactionItemDetails.expired;
        });
      },
    );

    print(pendingTransactionItemDetails.remainingTime);
  }

  goBack() {
    _navigationService.navigateBack();
  }

  cancel() async {
    this._alertService.showLoader();
    var res = await this._cancelTransaction(CancelTransactionParams(
        transactionRefId: pendingTransactionItemDetails.refrenceId,
        reasonForCancelleation: cancelTxnForm.control('reason').value));
    this._alertService.hideLoader();
    res.fold(
      (l) =>
          this._alertService.showAlertSnackbar(title: '', message: l.message!),
      (r) => _navigationService.navigateAndReplace(
          AppRouts.transactionCancelledPage,
          arguments: pendingTransactionItemDetails,
          result: true),
    );
  }

  T getCompleteTxnFormValue<T>(String controlName) {
    return (completeTxnForm.controls[controlName] as FormControl<T>).value!;
  }

  Future confirmTxn() async {
    if (completeTxnForm.valid) {
      _navigationService.navigateBack();
      var params = CompleteTransactionParams(
        transactionRefId: pendingTransactionItemDetails.refrenceId,
        pendingTxnBankRefNo:
            int.parse(completeTxnForm.control('reference_no').value),
        referenceDocPath:
            getCompleteTxnFormValue<ReferenceImage>('reference_image')
                .imagePath,
      );
      completeTransaction(params);
    } else
      completeTxnForm.markAllAsTouched();
  }

  completeTransaction(CompleteTransactionParams params) async {
    this._alertService.showLoader();
    var res = await this._completeTransaction(params);
    this._alertService.hideLoader();
    res.fold(
      (l) =>
          this._alertService.showAlertSnackbar(title: '', message: l.message!),
      (r) => _navigationService
          .navigateAndReplace(AppRouts.transactionCompletedPage, result: true),
    );
  }

  // String transactionStatusToString(TransactionStatus status) {
  //   String s;

  //   if (expired.value) {
  //     s = 'timeout'.tr;
  //     return s;
  //   } else
  //     switch (status) {
  //       case TransactionStatus.InProcess:
  //         s = 'in_process'.tr;
  //         break;
  //       case TransactionStatus.Success:
  //         s = 'successfull'.tr;
  //         break;
  //       case TransactionStatus.Failed:
  //         s = 'failed'.tr;
  //         break;
  //       case TransactionStatus.Pending:
  //         s = 'pending'.tr;
  //         break;
  //       case TransactionStatus.TimeOut:
  //         s = 'timeout'.tr;
  //         break;
  //       case TransactionStatus.UserCancelled:
  //         s = 'cancelled'.tr;
  //         break;
  //       default:
  //         s = 'undefined'.tr;
  //         break;
  //     }

  //   return s;
  // }

  // String getPaymentModeToString(PaymentMode pMode) {
  //   String mode;
  //   switch (pMode) {
  //     case PaymentMode.BankTransfer:
  //       mode = 'bank_transfer'.tr;
  //       break;
  //     case PaymentMode.CashDeposit:
  //       mode = 'cash_deposit'.tr;
  //       break;
  //     default:
  //       mode = 'undefined'.tr;
  //       break;
  //   }
  //   return mode;
  // }

  String dateToString(DateTime dateTime) {
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  String timeToString(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  // String transactionStatusToStringDetailed(TransactionStatus status) {
  //   String s;
  //   if (expired.value) {
  //     s = 'transaction_timeout'.tr;
  //     return s;
  //   } else
  //     switch (status) {
  //       case TransactionStatus.InProcess:
  //         s = 'transaction_is_in_process'.tr;
  //         break;
  //       case TransactionStatus.Success:
  //         s = 'transaction_successfull'.tr;
  //         break;
  //       case TransactionStatus.Failed:
  //         s = 'transaction_failed'.tr;
  //         break;
  //       case TransactionStatus.Pending:
  //         s = 'transaction_pending'.tr;
  //         break;
  //       case TransactionStatus.TimeOut:
  //         s = 'transaction_timeout'.tr;
  //         break;
  //       case TransactionStatus.UserCancelled:
  //         s = 'cancelled_by_user'.tr;
  //         break;
  //       default:
  //         s = 'undefined'.tr;
  //         break;
  //     }

  //   return s;
  // }

  //   String transactionStatusToImage(TransactionStatus status) {
  //   String assetImage;
  //   if (expired.value) {
  //     assetImage = AssetImages.notificationClose;
  //     return assetImage;
  //   } else
  //     switch (status) {
  //       case TransactionStatus.Pending:
  //         assetImage = AssetImages.notificationClose;
  //         break;
  //       case TransactionStatus.TimeOut:
  //         assetImage = AssetImages.notificationClose;
  //         break;
  //       case TransactionStatus.UserCancelled:
  //         assetImage = AssetImages.notificationClose;
  //         break;
  //       default:
  //         assetImage = AssetImages.notificationClose;
  //         break;
  //     }

  //   return assetImage;
  // }

  String transactionStatusToStringDetailed(TransactionStatus status) {
    String s;
    if (expired.value) {
      s = 'transaction_timeout'.tr;
      return s;
    } else
      switch (status.code) {
        case 1:
          s = 'transaction_is_in_process'.tr;
          break;
        case 2:
          s = 'transaction_successfull'.tr;
          break;
        case 3:
          s = 'transaction_failed'.tr;
          break;
        case 4:
          s = 'transaction_awaiting'.tr;
          break;
        case 5:
          s = 'transaction_cancelled'.tr;
          break;
        case 6:
          s = 'transaction_refunded'.tr;
          break;
        default:
          s = status.title;
          break;
      }

    return s;
  }

  String transactionStatusToImage(TransactionStatus status) {
    String assetImage;
    if (expired.value) {
      assetImage = AssetImages.txnFail;
      return assetImage;
    } else
      switch (status.code) {
        case 1:
        case 4:
          assetImage = AssetImages.txnPending;
          break;
        case 2:
        case 6:
          assetImage = AssetImages.txnSuccess;
          break;
        case 3:
        case 5:
          assetImage = AssetImages.txnFail;
          break;
        default:
          assetImage = '';
          break;
      }

    return assetImage;
  }
}
