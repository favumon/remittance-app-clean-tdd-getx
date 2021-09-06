import 'package:data/feature/transaction_history/models/payment_mode_model.dart';
import 'package:data/feature/transaction_history/models/transaction_status_model.dart';
import 'package:domain/feature/transaction_history/entities/pending_transaction_item_details_.dart';

class PendingTransactionItemDetailsModel extends PendingTransactionItemDetails {
  final int refrenceId;
  final String beneficiaryName;
  final String beneNickName;
  final String agentName;
  final String accountNumber;
  final String dateTimeOfTransaction;
  final int transactionTimeoutInMinutes;
  final PaymentModeModel paymentMode;
  final double fundSent;
  final double fundReceived;
  final String lcCurrency;
  final TransactionStatusModel transactionStatus;
  final String fcCurrency;

  PendingTransactionItemDetailsModel({
    required this.refrenceId,
    required this.accountNumber,
    required this.beneficiaryName,
    required this.beneNickName,
    required this.agentName,
    required this.dateTimeOfTransaction,
    required this.transactionTimeoutInMinutes,
    required this.lcCurrency,
    required this.paymentMode,
    required this.fundSent,
    required this.fundReceived,
    required this.transactionStatus,
    required this.fcCurrency,
  }) : super(
            refrenceId: refrenceId,
            beneficiaryName: beneficiaryName,
            beneNickName: beneNickName,
            agentName: agentName,
            accountNumber: accountNumber,
            dateTimeOfTransaction: dateTimeOfTransaction,
            transactionTimeoutInMinutes: transactionTimeoutInMinutes,
            paymentMode: paymentMode,
            fundSent: fundSent,
            fundReceived: fundReceived,
            lcCurrency: lcCurrency,
            transactionStatus: transactionStatus,
            fcCurrecny: fcCurrency);

  factory PendingTransactionItemDetailsModel.fromMap(
      Map<String, dynamic> json) {
    return PendingTransactionItemDetailsModel(
        refrenceId: json['transaction_ref_id'],
        accountNumber: json['account_number'],
        beneficiaryName: json['beneficiary_name'],
        beneNickName: json['bene_nick_name'],
        agentName: json['agent_name'],
        dateTimeOfTransaction: json['date_time_of_transaction'],
        transactionTimeoutInMinutes: json['transaction_timeout'],
        lcCurrency: json['lc_code'],
        paymentMode: PaymentModeModel.fromMap(json['payment_mode']),
        fundSent: json['fund_sent'],
        fundReceived: json['fund_received'],
        transactionStatus:
            TransactionStatusModel.fromMap(json['transaction_status']),
        fcCurrency: json['fc_code']);
  }
}
