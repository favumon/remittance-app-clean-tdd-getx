import 'package:domain/feature/user_profile/entities/update_user_info_request.dart';

class UpdateUserInfoModel extends UpdateUserInfoRequest {
  final String phoneNumber;

  UpdateUserInfoModel(this.phoneNumber) : super(phoneNumber);

  Map<String, dynamic> toMap() => {
        "phoneNumber": phoneNumber,
      };
}
