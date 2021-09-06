import 'package:equatable/equatable.dart';

class UpdateUserInfoRequest extends Equatable {
  final String phoneNumber;

  UpdateUserInfoRequest(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}
