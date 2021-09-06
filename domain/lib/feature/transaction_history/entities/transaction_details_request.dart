import 'package:equatable/equatable.dart';

class TransactionDetailsRequest extends Equatable {
  final int referenceId;
  TransactionDetailsRequest({required this.referenceId});

  @override
  List<Object?> get props => [referenceId];
}
