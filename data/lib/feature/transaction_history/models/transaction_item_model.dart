import 'package:data/feature/transaction_history/models/payment_mode_model.dart';
import 'package:data/feature/transaction_history/models/transaction_status_model.dart';
import 'package:domain/feature/transaction_history/entities/transaction_item.dart';

class TransactionItemModel extends TransactionItem {
  final String profileImageUrl;
  final String beneficiaryName;
  final int transactionRefId;
  final PaymentModeModel paymentMode;
  final double lcAmount;
  final String lcCurrency;
  final String transactionDateTime;
  final TransactionStatusModel transactionStatus;

  TransactionItemModel(
      {required this.profileImageUrl,
      required this.beneficiaryName,
      required this.transactionRefId,
      required this.paymentMode,
      required this.lcAmount,
      required this.lcCurrency,
      required this.transactionDateTime,
      required this.transactionStatus})
      : super(
            profileImageUrl: profileImageUrl,
            beneficiaryName: beneficiaryName,
            transactionRefId: transactionRefId,
            paymentMode: paymentMode,
            lcAmount: lcAmount,
            lcCurrency: lcCurrency,
            transactionDateTime: transactionDateTime,
            transactionStatus: transactionStatus);

  factory TransactionItemModel.fromMap(Map json) {
    return TransactionItemModel(
      profileImageUrl: json['bene_profile_url'],
      beneficiaryName: json['beneficiary_name'],
      transactionRefId: json['transaction_ref_id'],
      paymentMode: PaymentModeModel.fromMap(json['payment_mode']),
      lcAmount: json['lc_amount'],
      lcCurrency: json['lc_code'],
      transactionDateTime: json['date_time_of_transaction'],
      transactionStatus:
          TransactionStatusModel.fromMap(json['transaction_status']),
    );
  }
}
