import 'package:domain/feature/app_settings/entities/app_settings.dart';

class AppSettingsModel extends AppSettings {
  AppSettingsModel({
    required this.androidVersion,
    required this.iosVersion,
  }) : super(androidVersion: androidVersion, iosVersion: iosVersion);

  final String androidVersion;
  final String iosVersion;

  factory AppSettingsModel.fromMap(Map<String, dynamic> json) =>
      AppSettingsModel(
        androidVersion: json["android_version"],
        iosVersion: json["ios_version"],
      );
}
