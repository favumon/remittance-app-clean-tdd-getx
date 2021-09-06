import 'package:equatable/equatable.dart';

import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:domain/core/utils/helper_functions.dart' as helper;

class TransactionDetailsItem extends Equatable {
  final int refrenceId;
  final String beneficiaryName;
  final String agentName;
  final String branchName;
  final String cityName;
  final String countryName;
  final String swiftCode;
  final String accountNumber;
  final String dateTimeOfTransaction;
  final PaymentMode paymentMode;
  final double fundSent;
  final double fundReceived;
  final String lcCurrency;
  final String fcCurrency;
  final TransactionStatus transactionStatus;

  TransactionDetailsItem(
      {required this.refrenceId,
      required this.beneficiaryName,
      required this.agentName,
      required this.branchName,
      required this.cityName,
      required this.countryName,
      required this.swiftCode,
      required this.accountNumber,
      required this.dateTimeOfTransaction,
      required this.paymentMode,
      required this.fundSent,
      required this.fundReceived,
      required this.lcCurrency,
      required this.fcCurrency,
      required this.transactionStatus});

  DateTime get dateTimeOfTxn => helper.stringToDateTime(dateTimeOfTransaction);

  // helper.PaymentMode get paymentModeEnum =>
  //     helper.paymentModeCodeToEnum(paymentMode.code);

  // helper.TransactionStatus get transactionCodeEnum =>
  //     helper.transactionStatusCodeToEnum(transactionStatus.code);

  @override
  List<Object?> get props => [
        refrenceId,
        beneficiaryName,
        agentName,
        branchName,
        cityName,
        countryName,
        swiftCode,
        accountNumber,
        dateTimeOfTransaction,
        paymentMode,
        fundSent,
        fundReceived,
        lcCurrency,
        fcCurrency,
        transactionStatus
      ];
}
