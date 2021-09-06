import 'package:data/feature/notifications/models/disbursal_mode_model.dart';
import 'package:data/feature/notifications/models/payment_mode_model.dart';
import 'package:data/feature/notifications/models/transaction_status_model.dart';
import 'package:domain/feature/notifications/entity/notification_item.dart';

class NotificationItemModel extends NotificationItem {
  final int id;
  final int refrenceNo;
  final String ttNumber;
  final PaymentModeModel paymentMode;
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
  final TransactionStatusModel transactionStatus;
  final String transactionCompleteDateTime;
  final String lcCurrencyCode;
  final bool readStatus;
  final String fcCurrencyCode;
  final DisbursalModeModel disbursalMode;

  NotificationItemModel(
      {required this.id,
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
      required this.disbursalMode})
      : super(
            id: id,
            refrenceNo: refrenceNo,
            ttNumber: ttNumber,
            paymentMode: paymentMode,
            beneficiaryName: beneficiaryName,
            agentName: agentName,
            swiftCode: swiftCode,
            accountNo: accountNo,
            dateTimeOfTransaction: dateTimeOfTransaction,
            fcAmount: fcAmount,
            rate: rate,
            lcAmount: lcAmount,
            commision: commision,
            charges: charges,
            vat: vat,
            discount: discount,
            netAmount: netAmount,
            transactionStatus: transactionStatus,
            transactionCompleteDateTime: transactionCompleteDateTime,
            lcCurrencyCode: lcCurrencyCode,
            readStatus: readStatus,
            fcCurrencyCode: fcCurrencyCode,
            disbursalMode: disbursalMode);

  factory NotificationItemModel.fromMap(Map<String, dynamic> json) {
    return NotificationItemModel(
      id: json['id'],
      refrenceNo: json['transaction_ref_id'],
      ttNumber: json['tt_number'],
      paymentMode: PaymentModeModel.fromMap(json['payment_mode']),
      beneficiaryName: json['beneficiary_name'],
      agentName: json['agent_name'],
      swiftCode: json['swift_code'],
      accountNo: json['account_no'],
      dateTimeOfTransaction: json['date_time_of_transaction'],
      fcAmount: json['fc_amount'],
      rate: json['rate'],
      lcAmount: json['lc_amount'],
      commision: json['commision'],
      charges: json['charges'],
      vat: json['vat'],
      discount: json['discount'],
      netAmount: json['net_amount'],
      transactionStatus:
          TransactionStatusModel.fromMap(json['transaction_status']),
      transactionCompleteDateTime: json['transaction_complete_date_time'],
      lcCurrencyCode: json['lc_code'],
      readStatus: json['read_status'],
      fcCurrencyCode: json['fc_code'],
      disbursalMode: DisbursalModeModel.fromMap(json['disbursal_mode']),
    );
  }
}
