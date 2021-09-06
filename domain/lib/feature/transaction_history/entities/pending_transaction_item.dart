import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:equatable/equatable.dart';

import 'package:domain/core/utils/helper_functions.dart' as helper;

class PendingTransactionItem extends Equatable {
  final String profileImageUrl;
  final String beneficiaryName;
  final int transactionRefId;
  final PaymentMode paymentMode;
  final double lcAmount;
  final String lcCurrency;
  final String transactionDateTime;
  final TransactionStatus transactionStatus;

  PendingTransactionItem({
    required this.profileImageUrl,
    required this.beneficiaryName,
    required this.transactionRefId,
    required this.paymentMode,
    required this.lcAmount,
    required this.lcCurrency,
    required this.transactionDateTime,
    required this.transactionStatus,
  });

  DateTime get dateTimeOfTxn => helper.stringToDateTime(transactionDateTime);

  // helper.PaymentMode get paymentModeEnum => helper.paymentModeCodeToEnum(paymentMode.code);

  // helper.TransactionStatus get transactionCodeEnum =>
  //     helper.transactionStatusCodeToEnum(transactionStatus.code);

  @override
  List<Object?> get props => [
        profileImageUrl,
        beneficiaryName,
        transactionRefId,
        paymentMode,
        lcAmount,
        lcCurrency,
        transactionDateTime,
        transactionStatus
      ];
}
