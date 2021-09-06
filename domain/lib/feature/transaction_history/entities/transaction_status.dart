import 'package:equatable/equatable.dart';

class TransactionStatus extends Equatable {
  final String title;
  final int code;

  TransactionStatus({
    required this.title,
    required this.code,
  });

  @override
  List<Object?> get props => [
        title,
        code,
      ];
}
