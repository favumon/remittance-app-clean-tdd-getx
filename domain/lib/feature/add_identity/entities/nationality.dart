import 'package:equatable/equatable.dart';

class Nationality extends Equatable {
  final String nationalityName;
  final int nationalityId;

  Nationality(this.nationalityName, this.nationalityId);

  @override
  List<Object?> get props => [nationalityName, nationalityId];

  @override
  String toString() => nationalityName;
}
