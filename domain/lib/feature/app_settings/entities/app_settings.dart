import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final String iosVersion;
  final String androidVersion;

  AppSettings({
    required this.iosVersion,
    required this.androidVersion,
  });

  @override
  List<Object?> get props => [androidVersion, iosVersion];
}
