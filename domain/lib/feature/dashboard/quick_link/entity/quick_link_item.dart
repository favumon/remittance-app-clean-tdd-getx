import 'package:equatable/equatable.dart';

class QuickLinkItem extends Equatable {
  final String beneficiaryName;
  final String beneficiaryId;

  QuickLinkItem({required this.beneficiaryName, required this.beneficiaryId});

  @override
  List<Object?> get props => [beneficiaryName, beneficiaryId];
}
