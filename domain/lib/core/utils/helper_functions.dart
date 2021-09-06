import 'package:intl/intl.dart';

enum PaymentMode {
  BankTransfer,
  CashDeposit,
  PayAtCounter,
  Other,
}

enum TransactionStatus {
  InProcess,
  Success,
  Failed,
  Pending,
  UserCancelled,
  TimeOut,
  Undefined,
}

String paymentModeToCode(PaymentMode l) {
  return PaymentMode.BankTransfer == l
      ? 'BT'
      : PaymentMode.CashDeposit == l
          ? 'CD'
          : PaymentMode.PayAtCounter == l
              ? 'PC'
              : '';
}

PaymentMode paymentModeCodeToEnum(String code) {
  return code == 'BT'
      ? PaymentMode.BankTransfer
      : code == 'CD'
          ? PaymentMode.CashDeposit
          : code == 'PC'
              ? PaymentMode.PayAtCounter
              : PaymentMode.Other;
}

TransactionStatus transactionStatusCodeToEnum(int statusCode) {
  return statusCode == 0
      ? TransactionStatus.InProcess
      : statusCode == 1
          ? TransactionStatus.Success
          : statusCode == 2
              ? TransactionStatus.Failed
              : statusCode == 3
                  ? TransactionStatus.Pending
                  : statusCode == 4
                      ? TransactionStatus.TimeOut
                      : statusCode == 5
                          ? TransactionStatus.UserCancelled
                          : TransactionStatus.Undefined;
}

DateTime stringToDateTime(String dateTimeString) {
  return DateFormat("yyyy-MM-ddThh:mm:ss.sss").parse(dateTimeString);
}
