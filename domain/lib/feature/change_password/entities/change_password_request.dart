import 'package:equatable/equatable.dart';

class ChangePasswordRequest extends Equatable {
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [
        currentPassword,
        newPassword,
      ];
}
