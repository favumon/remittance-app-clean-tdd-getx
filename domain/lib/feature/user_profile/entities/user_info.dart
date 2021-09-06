import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profileImage;

  UserInfo(
      {required this.profileImage,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.phoneNumber,
      required this.email});

  @override
  List<Object?> get props =>
      [firstName, middleName, lastName, phoneNumber, email];
}
