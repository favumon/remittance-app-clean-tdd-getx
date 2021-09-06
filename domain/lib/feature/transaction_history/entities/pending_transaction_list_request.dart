import 'package:equatable/equatable.dart';

class PendingTransactionListRequest extends Equatable {
  final List<int> paymentModeFilterList;

  PendingTransactionListRequest({required this.paymentModeFilterList});

  // List<String> get paymentModeEnumListToStringList =>
  //     paymentModeFilterList.map((e) => paymentModeToCode(e)).toList();

  @override
  List<Object?> get props => [paymentModeFilterList];
}
