import 'package:equatable/equatable.dart';

class IdType extends Equatable {
  final String idTypeName;
  final int idTypeId;

  const IdType(this.idTypeName, this.idTypeId);

  @override
  List<Object?> get props => [idTypeName, idTypeId];

  @override
  String toString() => idTypeName;
}
