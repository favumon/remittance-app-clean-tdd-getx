import 'package:equatable/equatable.dart';

import 'package:domain/feature/notifications/entity/disbursal_mode.dart';
import 'package:domain/feature/notifications/entity/payment_mode.dart';
import 'package:domain/feature/notifications/entity/transaction_status.dart';
import 'package:domain/core/utils/helper_functions.dart' as helper;

class NotificationItem extends Equatable {
  final int id;
  final int refrenceNo;
  final String ttNumber;
  final PaymentMode paymentMode;
  final String beneficiaryName;
  final String agentName;
  final String swiftCode;
  final String accountNo;
  final String dateTimeOfTransaction;
  final double fcAmount;
  final double rate;
  final double lcAmount;
  final double commision;
  final double charges;
  final double vat;
  final double discount;
  final double netAmount;
  final TransactionStatus transactionStatus;
  final String transactionCompleteDateTime;
  final String lcCurrencyCode;
  final bool readStatus;
  final String fcCurrencyCode;
  final DisbursalMode disbursalMode;

  NotificationItem({
    required this.id,
    required this.refrenceNo,
    required this.ttNumber,
    required this.paymentMode,
    required this.beneficiaryName,
    required this.agentName,
    required this.swiftCode,
    required this.accountNo,
    required this.dateTimeOfTransaction,
    required this.fcAmount,
    required this.rate,
    required this.lcAmount,
    required this.commision,
    required this.charges,
    required this.vat,
    required this.discount,
    required this.netAmount,
    required this.transactionStatus,
    required this.transactionCompleteDateTime,
    required this.lcCurrencyCode,
    required this.readStatus,
    required this.fcCurrencyCode,
    required this.disbursalMode,
  });

  DateTime get dateTimeofTxn => helper.stringToDateTime(dateTimeOfTransaction);

  DateTime get txnCompleteDateTime =>
      helper.stringToDateTime(transactionCompleteDateTime);

  // helper.PaymentMode get paymentModeEnum =>
  //     helper.paymentModeCodeToEnum(paymentMode.code);

  // helper.TransactionStatus get transactionCodeEnum =>
  //     helper.transactionStatusCodeToEnum(transactionStatus.code);

  @override
  List<Object?> get props => [
        id,
        refrenceNo,
        ttNumber,
        paymentMode,
        beneficiaryName,
        agentName,
        swiftCode,
        accountNo,
        dateTimeOfTransaction,
        fcAmount,
        rate,
        lcAmount,
        commision,
        charges,
        vat,
        discount,
        netAmount,
        paymentMode,
        transactionCompleteDateTime,
        lcCurrencyCode,
        readStatus,
        fcCurrencyCode,
        disbursalMode
      ];
}
