import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:equatable/equatable.dart';

import 'package:domain/core/utils/helper_functions.dart' as helper;

class PendingTransactionItemDetails extends Equatable {
  final int refrenceId;
  final String beneficiaryName;
  final String beneNickName;
  final String agentName;
  final String accountNumber;
  final String dateTimeOfTransaction;
  final PaymentMode paymentMode;
  final double fundSent;
  final double fundReceived;
  final String lcCurrency;
  final String fcCurrecny;
  final int transactionTimeoutInMinutes;
  final TransactionStatus transactionStatus;

  PendingTransactionItemDetails({
    required this.refrenceId,
    required this.beneficiaryName,
    required this.beneNickName,
    required this.agentName,
    required this.accountNumber,
    required this.dateTimeOfTransaction,
    required this.paymentMode,
    required this.fundSent,
    required this.fundReceived,
    required this.lcCurrency,
    required this.fcCurrecny,
    required this.transactionStatus,
    required this.transactionTimeoutInMinutes,
  });

  DateTime get dateTimeOfTxn => helper.stringToDateTime(dateTimeOfTransaction);

  // helper.PaymentMode get paymentModeEnum =>
  //     helper.paymentModeCodeToEnum(paymentMode.code);

  // helper.TransactionStatus get transactionCodeEnum =>
  //     helper.transactionStatusCodeToEnum(transactionStatus.code);

  String get remainingTime {
    var diff = dateTimeOfTxn
        .add(Duration(minutes: transactionTimeoutInMinutes))
        .difference(DateTime.now());

    if (diff.isNegative) {
      return '00:00:00';
    } else {
      var totalSseconds = diff.inSeconds;
      var minutes = totalSseconds ~/ 60;
      var sec = totalSseconds % 60;
      var hours = minutes ~/ 60;
      var s = sec < 10 ? '0$sec' : sec;
      var m = minutes < 10 ? '0$minutes' : minutes;
      var h = hours < 10 ? '0$hours' : hours;

      return '$h:$m:$s';
    }
  }

  get expired => dateTimeOfTxn
      .add(Duration(minutes: transactionTimeoutInMinutes))
      .difference(DateTime.now())
      .isNegative;

  @override
  List<Object?> get props => [
        refrenceId,
        beneficiaryName,
        agentName,
        accountNumber,
        dateTimeOfTransaction,
        paymentMode,
        fundSent,
        fundReceived,
        lcCurrency,
        transactionStatus,
        beneNickName,
        fcCurrecny,
        transactionTimeoutInMinutes
      ];
}
