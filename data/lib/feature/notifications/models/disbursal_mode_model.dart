import 'package:domain/feature/notifications/entity/disbursal_mode.dart';

class DisbursalModeModel extends DisbursalMode {
  final String title;
  final String code;

  DisbursalModeModel({
    required this.title,
    required this.code,
  }) : super(code: code, title: title);

  factory DisbursalModeModel.fromMap(Map<String, dynamic> json) {
    return DisbursalModeModel(
      title: json['disbursal_mode_title'],
      code: json['disbursal_mode_code'],
    );
  }
}
