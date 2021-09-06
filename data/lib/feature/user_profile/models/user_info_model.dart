import 'package:domain/feature/user_profile/entities/user_info.dart';

class UserInfoModel extends UserInfo {
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String profileImage;

  UserInfoModel(
      {required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.phoneNumber,
      required this.email,
      required this.profileImage})
      : super(
            email: email,
            firstName: firstName,
            lastName: lastName,
            middleName: middleName,
            phoneNumber: phoneNumber,
            profileImage: profileImage);

  factory UserInfoModel.fromMap(Map<String, dynamic> json) => UserInfoModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      middleName: json["middle_name"],
      phoneNumber: json["phone"],
      profileImage: json["profileImage"]);
}
