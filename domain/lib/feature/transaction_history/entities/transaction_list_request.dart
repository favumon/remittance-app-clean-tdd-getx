import 'package:equatable/equatable.dart';

class TransactionListRequest extends Equatable {
  final List<int> paymentModeFilterList;

  TransactionListRequest({required this.paymentModeFilterList});

  @override
  List<Object?> get props => [paymentModeFilterList];
}
