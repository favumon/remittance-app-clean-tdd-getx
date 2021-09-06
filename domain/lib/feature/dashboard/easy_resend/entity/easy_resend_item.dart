import 'package:equatable/equatable.dart';

class EasyResendItem extends Equatable {
  final String beneficiaryName;
  final int transactionRefNumber;
  final String transactionDate;
  final double beneficiaryCurrencyAmount;
  final String beneficiaryCurrencyCode;
  EasyResendItem(
      {required this.beneficiaryName,
      required this.transactionRefNumber,
      required this.transactionDate,
      required this.beneficiaryCurrencyAmount,
      required this.beneficiaryCurrencyCode});

  @override
  List<Object?> get props => [
        beneficiaryName,
        transactionRefNumber,
        transactionDate,
        beneficiaryCurrencyAmount,
        beneficiaryCurrencyCode
      ];
}
