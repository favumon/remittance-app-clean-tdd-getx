import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_item.dart';

class EasyResendItemModel extends EasyResendItem {
  final String beneficiaryName;
  final int transactionRefNumber;
  final String transactionDate;
  final double beneficiaryCurrencyAmount;
  final String beneficiaryCurrencyCode;
  EasyResendItemModel(
      {required this.beneficiaryName,
      required this.transactionRefNumber,
      required this.transactionDate,
      required this.beneficiaryCurrencyAmount,
      required this.beneficiaryCurrencyCode})
      : super(
          beneficiaryName: beneficiaryName,
          transactionRefNumber: transactionRefNumber,
          transactionDate: transactionDate,
          beneficiaryCurrencyAmount: beneficiaryCurrencyAmount,
          beneficiaryCurrencyCode: beneficiaryCurrencyCode,
        );

  factory EasyResendItemModel.fromMap(Map<String, dynamic> json) {
    return EasyResendItemModel(
      beneficiaryName: json['beneficiary_name'],
      transactionRefNumber: json['transaction_ref_number'],
      transactionDate: json['transaction_date'],
      beneficiaryCurrencyAmount: json['beneficiary_currency_amount'],
      beneficiaryCurrencyCode: json['beneficiary_currency_code'],
    );
  }
}
