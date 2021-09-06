import 'package:dartz/dartz.dart';
import 'package:domain/feature/transaction_history/entities/reference_image.dart';
import 'package:domain/feature/transaction_history/entities/transaction_payment_mode_filter.dart';
import 'package:injectable/injectable.dart';

import 'package:data/feature/transaction_history/datasources/transaction_history_datasource.dart';
import 'package:data/feature/transaction_history/models/cancel_transaction_request_model.dart';
import 'package:data/feature/transaction_history/models/complete_transaction_request_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_details_request_model.dart';
import 'package:data/feature/transaction_history/models/pending_transaction_list_request_model.dart';
import 'package:data/feature/transaction_history/models/transaction_detail_request_model.dart';
import 'package:data/feature/transaction_history/models/transaction_list_request_model.dart';
import 'package:domain/feature/transaction_history/entities/complete_transaction_request.dart';
import 'package:domain/feature/transaction_history/entities/cancel_transaction_request.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_list_request.dart';
import 'package:domain/feature/transaction_history/entities/transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_request.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item_details_.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_list_request.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_details_request.dart';
import 'package:core/error/failures.dart';
import 'package:domain/feature/transaction_history/repositories/transaction_history_repository.dart';

@LazySingleton(as: TransactionHistoryRepository)
class TransactionHistoryRepositoryImpl extends TransactionHistoryRepository {
  final TransactionHistoryDataSource _dataSource;

  TransactionHistoryRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, PendingTransactionItemDetails>>
      getPendingTransactionItemDetails(
          PendingTransactionDetailsRequest request) async {
    return _dataSource.requestPendingTransactionDetails(
        PendingTransactionDetailsRequestModel(request.referenceId));
  }

  @override
  Future<Either<Failure, List<PendingTransactionItem>>>
      getPendingTransactionsList(PendingTransactionListRequest request) async {
    return await _dataSource.requestPendingTransactionHistory(
        PendingTransactionListRequestModel(request.paymentModeFilterList));
  }

  @override
  Future<Either<Failure, TransactionDetailsItem>> getTransactionItemDetails(
      TransactionDetailsRequest request) async {
    return await _dataSource.requestTransactionDetails(
        TransactionDetailsRequestModel(refrenceId: request.referenceId));
  }

  @override
  Future<Either<Failure, List<TransactionItem>>> getTransactionsList(
      TransactionListRequest transactionListRequest) async {
    return await _dataSource
        .requestTransactionHistory(TransactionListRequestModel(
      transactionListRequest.paymentModeFilterList,
    ));
  }

  @override
  Future<Either<Failure, CommonApiResponse>> cancelPendingTransaction(
      CancelTransactionRequest request) async {
    return await _dataSource.cancelPendingTransaction(
        CancelTransactionRequestModel(request.transRefId, request.reason));
  }

  @override
  Future<Either<Failure, CommonApiResponse>> confirmPendingTransaction(
      CompleteTransactionRequest request) async {
    return await _dataSource.completePendingTransaction(
      CompleteTransactionRequestModel(
        transRefId: request.transRefId,
        pendingTxnBankRefNo: request.pendingTxnBankRefNo,
        docPath: request.referenceDocPath,
      ),
    );
  }

  @override
  Future<Either<Failure, ReferenceImage>> getReferenceImage() async {
    return await _dataSource.getIdImage();
  }

  @override
  Future<Either<Failure, List<TransactionPaymentModeFilter>>>
      getTransactionFilters() async {
    return await _dataSource.requestTxnsPaymentModeFilters();
  }
}
