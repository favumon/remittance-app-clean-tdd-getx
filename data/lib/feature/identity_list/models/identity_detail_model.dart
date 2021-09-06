import 'package:domain/feature/identity_list/entities/identity_details.dart';

class IdentityDetailModel extends IdentityDetails {
  IdentityDetailModel({
    required this.idNumber,
    required this.idType,
    required this.expiryDate,
    required this.nationality,
    required this.profileImageUrl,
    required this.singatureUrl,
  }) : super(
            expiryDate: expiryDate,
            idNumber: idNumber,
            idType: idType,
            nationality: nationality,
            profileImageUrl: profileImageUrl,
            signatureUrl: singatureUrl);

  final String idNumber;
  final String idType;
  final DateTime expiryDate;
  final String nationality;
  final String profileImageUrl;
  final String singatureUrl;

  factory IdentityDetailModel.fromJson(Map<String, dynamic> json) =>
      IdentityDetailModel(
        idNumber: json["id_number"],
        idType: json["id_type"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        nationality: json["nationality"],
        profileImageUrl: json["profile_image_url"],
        singatureUrl: json["singature_url"],
      );
}
