import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class IdentityDetails extends Equatable {
  final String idType;
  final String idNumber;
  final DateTime expiryDate;
  final String signatureUrl;
  final String profileImageUrl;
  final String nationality;

  IdentityDetails(
      {required this.idType,
      required this.idNumber,
      required this.expiryDate,
      required this.nationality,
      required this.signatureUrl,
      required this.profileImageUrl});

  String get expiryDateFormatted => DateFormat('dd/MM/yyyy').format(expiryDate);

  @override
  List<Object?> get props => [
        this.idType,
        this.idNumber,
        this.expiryDate,
        this.signatureUrl,
        this.profileImageUrl,
        this.nationality,
      ];
}
