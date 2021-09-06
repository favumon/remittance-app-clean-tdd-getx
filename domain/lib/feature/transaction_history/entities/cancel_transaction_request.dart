import 'package:equatable/equatable.dart';

class CancelTransactionRequest extends Equatable {
  final int transRefId;
  final String reason;

  CancelTransactionRequest({required this.transRefId, this.reason = ''});

  @override
  List<Object?> get props => [transRefId, reason];
}
