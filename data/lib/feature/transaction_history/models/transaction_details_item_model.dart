import 'package:data/feature/transaction_history/models/payment_mode_model.dart';
import 'package:data/feature/transaction_history/models/transaction_status_model.dart';
import 'package:domain/feature/transaction_history/entities/transaction_details_item.dart';

class TransactionDetailsItemModel extends TransactionDetailsItem {
  final int refrenceId;
  final String beneficiaryName;
  final String agentName;
  final String branchName;
  final String cityName;
  final String countryName;
  final String swiftCode;
  final String accountNumber;
  final String dateTimeOfTransaction;
  final PaymentModeModel paymentMode;
  final double fundSent;
  final double fundReceived;
  final String lcCurrency;
  final TransactionStatusModel transactionStatus;
  final String fcCurrency;

  TransactionDetailsItemModel({
    required this.refrenceId,
    required this.accountNumber,
    required this.beneficiaryName,
    required this.agentName,
    required this.branchName,
    required this.cityName,
    required this.countryName,
    required this.swiftCode,
    required this.dateTimeOfTransaction,
    required this.lcCurrency,
    required this.paymentMode,
    required this.fundSent,
    required this.fundReceived,
    required this.transactionStatus,
    required this.fcCurrency,
  }) : super(
            refrenceId: refrenceId,
            beneficiaryName: beneficiaryName,
            agentName: agentName,
            branchName: branchName,
            cityName: cityName,
            countryName: countryName,
            swiftCode: swiftCode,
            accountNumber: accountNumber,
            dateTimeOfTransaction: dateTimeOfTransaction,
            paymentMode: paymentMode,
            fundSent: fundSent,
            fundReceived: fundReceived,
            lcCurrency: lcCurrency,
            transactionStatus: transactionStatus,
            fcCurrency: fcCurrency);

  factory TransactionDetailsItemModel.fromMap(Map<String, dynamic> json) {
    return TransactionDetailsItemModel(
        refrenceId: json['transaction_ref_id'],
        accountNumber: json['account_number'],
        beneficiaryName: json['beneficiary_name'],
        agentName: json['agent_name'],
        branchName: json['branch_name'],
        cityName: json['city_name'],
        countryName: json['country_name'],
        swiftCode: json['swift_code'],
        dateTimeOfTransaction: json['date_time_of_transaction'],
        lcCurrency: json['lc_code'],
        paymentMode: PaymentModeModel.fromMap(json['payment_mode']),
        fundSent: json['fund_sent'],
        fundReceived: json['fund_received'],
        transactionStatus:
            TransactionStatusModel.fromMap(json['transaction_status']),
        fcCurrency: json['fc_code']);
  }
}
