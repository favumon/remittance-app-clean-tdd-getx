import 'package:domain/feature/add_identity/entities/id_type.dart';

class IdTypeModel extends IdType {
  final String idTypeName;
  final int idTypeId;

  IdTypeModel({required this.idTypeName, required this.idTypeId})
      : super(idTypeName, idTypeId);

  factory IdTypeModel.fromJson(Map<String, dynamic> json) => IdTypeModel(
        idTypeId: json["id_type_id"],
        idTypeName: json["id_type_name"],
      );

  Map<String, dynamic> toJson() => {
        "id_type_id": idTypeId,
        "id_type_name": idTypeName,
      };
}
