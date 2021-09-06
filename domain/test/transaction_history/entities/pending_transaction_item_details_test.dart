import 'package:domain/core/utils/helper_functions.dart' as helper;
import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item_details_.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([])
main() {
  late PendingTransactionItemDetails pendingTransactionItemDetails;

  setUp(() {
    pendingTransactionItemDetails = PendingTransactionItemDetails(
        beneficiaryName: '',
        lcCurrency: '',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        transactionStatus: TransactionStatus(code: 0, title: 'In Processs'),
        dateTimeOfTransaction: '2012-02-28T14:50:00.000',
        accountNumber: '',
        agentName: '',
        fundReceived: 1,
        fundSent: 1,
        refrenceId: 1,
        transactionTimeoutInMinutes: 10,
        fcCurrecny: '',
        beneNickName: '');
  });

  // test('should return a PaymentMode enum when paymentModeEnum getter called',
  //     () {
  //   final result = pendingTransactionItemDetails.paymentModeEnum;

  //   expect(result.runtimeType, anyOf(PaymentMode));
  // });

  // test(
  //     'should return a TransactionStatus enum when transactionCodeEnum getter called',
  //     () {
  //   final result = pendingTransactionItemDetails.transactionCodeEnum;

  //   expect(result.runtimeType, anyOf(TransactionStatus));
  // });

  test('should return a DateTime when dateTimeOfTxn getter called', () {
    final result = pendingTransactionItemDetails.dateTimeOfTxn;

    expect(result.runtimeType, anyOf(DateTime));
  });

  test('should return a bool when expired getter called', () {
    final result = pendingTransactionItemDetails.expired;

    expect(result.runtimeType, anyOf(bool));
  });

  test('should return a String when remainingTime getter called', () {
    final result = pendingTransactionItemDetails.remainingTime;

    expect(result.runtimeType, anyOf(String));
  });
}
