import 'package:domain/feature/dashboard/quick_link/entity/quick_link_item.dart';

class QuickLinkModel extends QuickLinkItem {
  final String beneficiaryName;
  final String beneficiaryId;
  QuickLinkModel({required this.beneficiaryName, required this.beneficiaryId})
      : super(beneficiaryName: beneficiaryName, beneficiaryId: beneficiaryId);

  factory QuickLinkModel.fromMap(Map<String, dynamic> json) {
    return QuickLinkModel(
        beneficiaryName: json['beneficiary_name'],
        beneficiaryId: json['beneficiary_id']);
  }
}
