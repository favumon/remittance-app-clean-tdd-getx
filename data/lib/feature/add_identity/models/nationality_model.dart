import 'package:domain/feature/add_identity/entities/nationality.dart';

class NationalityModel extends Nationality {
  final String nationalityName;
  final int nationalityId;

  NationalityModel({required this.nationalityName, required this.nationalityId})
      : super(nationalityName, nationalityId);

  factory NationalityModel.fromJson(Map<String, dynamic> json) =>
      NationalityModel(
        nationalityId: json["nationality_id"],
        nationalityName: json["nationality_name"],
      );

  Map<String, dynamic> toJson() => {
        "nationality_id": nationalityId,
        "nationality_name": nationalityName,
      };
}
