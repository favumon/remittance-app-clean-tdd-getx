import 'package:equatable/equatable.dart';

class DisbursalMode extends Equatable {
  final String title;
  final String code;

  DisbursalMode({
    required this.title,
    required this.code,
  });

  @override
  List<Object?> get props => [
        title,
        code,
      ];
}
