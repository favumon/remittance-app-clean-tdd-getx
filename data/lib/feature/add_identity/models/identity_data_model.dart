import 'package:dio/dio.dart';
import 'package:domain/feature/add_identity/entities/identity_data.dart';

class IdentityDataModel extends IdentityData {
  final int idType;
  final String idNumber;
  final String expiryDate;
  final String idImage1Path;
  final String idImage2Path;
  final String idSignaturePath;
  final int nationality;
  final String dateOfBirth;

  IdentityDataModel(
      this.idType,
      this.idNumber,
      this.expiryDate,
      this.idImage1Path,
      this.idImage2Path,
      this.idSignaturePath,
      this.nationality,
      this.dateOfBirth)
      : super(idType, idNumber, expiryDate, idImage1Path, idImage2Path,
            idSignaturePath, nationality, dateOfBirth);

  Future<FormData> toFormData() async => FormData.fromMap({
        'idType': idType,
        'idNumber': idNumber,
        'expiryDate': expiryDate,
        'nationality': nationality,
        'dateOfBirth': dateOfBirth,
        // 'idImageFront': await MultipartFile.fromFile(idImage1Path),
        // 'idImageBack': await MultipartFile.fromFile(idImage2Path),
        // 'signature': await MultipartFile.fromFile(idSignaturePath),
      });
}
