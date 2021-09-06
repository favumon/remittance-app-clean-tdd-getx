import 'package:equatable/equatable.dart';

class PendingTransactionCountItem extends Equatable {
  final int pendingTransactionCount;

  PendingTransactionCountItem({required this.pendingTransactionCount});

  @override
  List<Object?> get props => [pendingTransactionCount];
}
