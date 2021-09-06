import 'package:domain/core/utils/helper_functions.dart' as helper;
import 'package:domain/feature/transaction_history/entities/payment_mode.dart';
import 'package:domain/feature/transaction_history/entities/transaction_item.dart';
import 'package:domain/feature/transaction_history/entities/transaction_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([])
main() {
  late TransactionItem transactionItem;

  setUp(() {
    transactionItem = TransactionItem(
        beneficiaryName: '',
        lcCurrency: '',
        paymentMode: PaymentMode(code: 13, title: 'Bank Transfer'),
        transactionStatus: TransactionStatus(code: 1, title: 'Successful'),
        lcAmount: 1,
        profileImageUrl: '',
        transactionDateTime: '2012-02-28T14:50:00.000',
        transactionRefId: 1);
  });

  // test('should return a PaymentMode enum when paymentModeEnum getter called',
  //     () {
  //   final result = transactionItem.paymentModeEnum;

  //   expect(result.runtimeType, anyOf(PaymentMode));
  // });

  // test(
  //     'should return a TransactionStatus enum when transactionCodeEnum getter called',
  //     () {
  //   final result = transactionItem.transactionCodeEnum;

  //   expect(result.runtimeType, anyOf(TransactionStatus));
  // });

  test('should return a DateTime when dateTimeOfTxn getter called', () {
    final result = transactionItem.dateTimeOfTxn;

    expect(result.runtimeType, anyOf(DateTime));
  });
}
