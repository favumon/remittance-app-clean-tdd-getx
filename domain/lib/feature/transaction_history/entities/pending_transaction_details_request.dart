import 'package:equatable/equatable.dart';

class PendingTransactionDetailsRequest extends Equatable {
  final int referenceId;
  PendingTransactionDetailsRequest({required this.referenceId});

  @override
  List<Object?> get props => [referenceId];
}
