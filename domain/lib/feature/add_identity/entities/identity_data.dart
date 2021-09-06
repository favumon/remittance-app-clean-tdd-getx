import 'package:equatable/equatable.dart';

class IdentityData extends Equatable {
  final int idType;
  final String idNumber;
  final String expiryDate;
  final String idImage1Path;
  final String idImage2Path;
  final String idSignaturePath;
  final int nationality;
  final String dateOfBirth;

  IdentityData(
      this.idType,
      this.idNumber,
      this.expiryDate,
      this.idImage1Path,
      this.idImage2Path,
      this.idSignaturePath,
      this.nationality,
      this.dateOfBirth);

  @override
  List<Object?> get props => [
        this.idType,
        this.idNumber,
        this.expiryDate,
        this.idImage1Path,
        this.idImage2Path,
        this.idSignaturePath,
        this.nationality,
        this.dateOfBirth
      ];
}
