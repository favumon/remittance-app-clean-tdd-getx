import 'dart:async';

import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/app_settings/data_sources/app_settings_remote_data_source.dart';
import 'package:domain/feature/app_settings/entities/app_settings.dart';
import 'package:domain/feature/app_settings/repositories/app_settings_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppSettingsRepository)
class AppSettingsRepositoryImpl extends AppSettingsRepository {
  final AppSettingsRemoteDataSource appSettingsRemoteDataSource;

  AppSettingsRepositoryImpl(this.appSettingsRemoteDataSource);

  @override
  Future<Either<Failure, AppSettings>> getAppSettings() async {
    return await appSettingsRemoteDataSource.getAppSettings();
  }
}
