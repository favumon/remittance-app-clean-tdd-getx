import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:domain/core/utils/helper_functions.dart' as helper;
import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_item.dart';

@GenerateMocks([])
main() {
  late TransactionDetailsItem transactionDetailsItem;

  setUp(() {
    transactionDetailsItem = TransactionDetailsItem(
        beneficiaryName: '',
        lcCurrency: '',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        transactionStatus: TransactionStatus(code: 1, title: 'Successful'),
        dateTimeOfTransaction: '2012-02-27T13:27:00.000',
        accountNumber: '',
        agentName: '',
        branchName: '',
        cityName: '',
        countryName: '',
        fcCurrency: '',
        fundReceived: 1,
        fundSent: 1,
        refrenceId: 1,
        swiftCode: '');
  });

  // test('should return a PaymentMode enum when paymentModeEnum getter called',
  //     () {
  //   final result = transactionDetailsItem.paymentModeEnum;

  //   expect(result.runtimeType, anyOf(PaymentMode));
  // });

  // test(
  //     'should return a TransactionStatus enum when transactionCodeEnum getter called',
  //     () {
  //   final result = transactionDetailsItem.transactionCodeEnum;

  //   expect(result.runtimeType, anyOf(TransactionStatus));
  // });

  test('should return a DateTime when dateTimeOfTxn getter called', () {
    final result = transactionDetailsItem.dateTimeOfTxn;

    expect(result.runtimeType, anyOf(DateTime));
  });
}
