import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:core/error/failures.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/device/image_picker.dart';
import 'package:data/core/models/common_api_response_model.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/transaction_history/models/cancel_transaction_request_model.dart';
import 'package:data/feature/transaction_history/models/complete_transaction_request_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_item_details_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_details_request_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_item_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_list_request_model.dart';
import 'package:data/feature/transaction_history/models/reference_image_model.dart';
import 'package:data/feature/transaction_history/models/transaction_detail_request_model.dart';
import 'package:data/feature/transaction_history/models/transaction_details_item_model.dart';
import 'package:data/feature/transaction_history/models/transaction_item_model.dart';
import 'package:data/feature/transaction_history/models/transaction_list_request_model.dart';
import 'package:data/feature/transaction_history/models/transaction_payment_mode_filter_model.dart';

@lazySingleton
class TransactionHistoryDataSource {
  final RemoteApi _remoteApi;
  final ApiEndpoints _endpoints;
  final ImagePicker _imagePicker;

  TransactionHistoryDataSource(
      this._remoteApi, this._endpoints, this._imagePicker);

  Future<Either<Failure, TransactionDetailsItemModel>>
      requestTransactionDetails(
          TransactionDetailsRequestModel requestModel) async {
    var response = await _remoteApi.apiGet(_endpoints.transactionDetails,
        queryParameters: requestModel.toMap());

    return response.fold(
      (l) => Left(l),
      (r) => Right(TransactionDetailsItemModel.fromMap(r)),
    );
  }

  Future<Either<Failure, List<TransactionItemModel>>> requestTransactionHistory(
      TransactionListRequestModel requestModel) async {
    var response = await _remoteApi.apiGet(_endpoints.transactionHistoryList,
        queryParameters: requestModel.toMap());

    return response.fold(
      (l) => Left(l),
      (r) => Right(r
          .map((e) => TransactionItemModel.fromMap(e))
          .toList()
          .cast<TransactionItemModel>()),
    );
  }

  Future<Either<Failure, List<PendingTransactionItemModel>>>
      requestPendingTransactionHistory(
          PendingTransactionListRequestModel requestModel) async {
    var response = await _remoteApi.apiGet(
        _endpoints.pendingTransactionHistoryList,
        queryParameters: requestModel.toMap());

    return response.fold(
      (l) => Left(l),
      (r) => Right(r
          .map((e) => PendingTransactionItemModel.fromMap(e))
          .toList()
          .cast<PendingTransactionItemModel>()),
    );
  }

  Future<Either<Failure, PendingTransactionItemDetailsModel>>
      requestPendingTransactionDetails(
          PendingTransactionDetailsRequestModel requestModel) async {
    var response = await _remoteApi.apiGet(_endpoints.pendingTransactionDetails,
        queryParameters: requestModel.toMap());

    return response.fold(
      (l) => Left(l),
      (r) => Right(PendingTransactionItemDetailsModel.fromMap(r)),
    );
  }

  Future<Either<Failure, CommonApiResponseModel>> cancelPendingTransaction(
      CancelTransactionRequestModel requestModel) async {
    var response = await _remoteApi.apiPost(_endpoints.cancelPendingTransaction,
        data: requestModel.toMap());

    return response.fold(
      (l) => Left(l),
      (r) => Right(CommonApiResponseModel.fromMap(r)),
    );
  }

  Future<Either<Failure, CommonApiResponseModel>> completePendingTransaction(
      CompleteTransactionRequestModel requestModel) async {
    var response = await _remoteApi.apiPost(
        _endpoints.completePendingTransaction,
        data: await requestModel.toFormData());

    return response.fold(
      (l) => Left(l),
      (r) => Right(CommonApiResponseModel.fromMap(r)),
    );
  }

  Future<Either<Failure, ReferenceImageModel>> getIdImage() async {
    var image = await _imagePicker.pickImageFromGallery();
    if (image != null)
      return Right(ReferenceImageModel(
        image.path,
        image.path.split('/').last,
      ));

    return Left(ImagePickFailure());
  }

  Future<Either<Failure, List<TransactionPaymentModeFilterModel>>>
      requestTxnsPaymentModeFilters() async {
    var response = await _remoteApi.apiGet(_endpoints.transactionFilterList);

    return response.fold(
      (l) => Left(l),
      (r) => Right(r
          .map((e) => TransactionPaymentModeFilterModel.fromMap(e))
          .toList()
          .cast<TransactionPaymentModeFilterModel>()),
    );
  }
}
