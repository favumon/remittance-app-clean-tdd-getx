import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/app_settings/data_sources/app_settings_remote_data_source.dart';
import 'package:data/feature/app_settings/models/app_settings_model.dart';
import 'package:data/feature/app_settings/repositories/app_settings_repository_impl.dart';
import 'package:domain/feature/app_settings/entities/app_settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_settings_repository_impl_test.mocks.dart';

@GenerateMocks([AppSettingsRemoteDataSource])
main() {
  late AppSettingsRepositoryImpl appSettingsRepositoryImpl;
  late MockAppSettingsRemoteDataSource mockAppSettingsRemoteDataSource;
  setUp(() {
    mockAppSettingsRemoteDataSource = MockAppSettingsRemoteDataSource();
    appSettingsRepositoryImpl =
        AppSettingsRepositoryImpl(mockAppSettingsRemoteDataSource);
  });
  test('should get appsettings from MockAppSettingsRemoteDataSource', () async {
    final androidVersion = '1.0';
    final iosVersion = '1.0';
    final model = AppSettingsModel(
        androidVersion: androidVersion, iosVersion: iosVersion);
    final entity = model;
    when(mockAppSettingsRemoteDataSource.getAppSettings())
        .thenAnswer((realInvocation) => Future.value(Right(model)));

    final result = await appSettingsRepositoryImpl.getAppSettings();

    expect(result, equals(Right<Failure, AppSettings>(entity)));
    verify(mockAppSettingsRemoteDataSource.getAppSettings());
    verifyNoMoreInteractions(mockAppSettingsRemoteDataSource);
  });
}
