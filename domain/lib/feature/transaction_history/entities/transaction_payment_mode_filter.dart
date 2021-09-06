import 'package:equatable/equatable.dart';

class TransactionPaymentModeFilter extends Equatable {
  final String title;
  final int code;

  TransactionPaymentModeFilter({required this.title, required this.code});

  @override
  List<Object?> get props => [title, code];
}
