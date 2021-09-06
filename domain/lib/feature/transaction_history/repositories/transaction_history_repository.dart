import 'package:dartz/dartz.dart';

import 'package:core/error/failures.dart';
import 'package:domain/core/common_api_response.dart';
import 'package:domain/feature/transaction_history/entities/cancel_transaction_request.dart';
import 'package:domain/feature/transaction_history/entities/complete_transaction_request.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item_details_.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_list_request.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_details_request.dart';
import 'package:domain/feature/transaction_history/entities/reference_image.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_request.dart';
import 'package:domain/feature/transaction_history/entities/transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_list_request.dart';
import 'package:domain/feature/transaction_history/entities/transaction_payment_mode_filter.dart';

abstract class TransactionHistoryRepository {
  Future<Either<Failure, List<TransactionItem>>> getTransactionsList(
      TransactionListRequest transactionListRequest);
  Future<Either<Failure, TransactionDetailsItem>> getTransactionItemDetails(
      TransactionDetailsRequest request);

  Future<Either<Failure, PendingTransactionItemDetails>>
      getPendingTransactionItemDetails(
          PendingTransactionDetailsRequest request);
  Future<Either<Failure, List<PendingTransactionItem>>>
      getPendingTransactionsList(PendingTransactionListRequest request);

  Future<Either<Failure, CommonApiResponse>> cancelPendingTransaction(
      CancelTransactionRequest request);
  Future<Either<Failure, CommonApiResponse>> confirmPendingTransaction(
      CompleteTransactionRequest request);

  Future<Either<Failure, ReferenceImage>> getReferenceImage();

  Future<Either<Failure, List<TransactionPaymentModeFilter>>>
      getTransactionFilters();
}
