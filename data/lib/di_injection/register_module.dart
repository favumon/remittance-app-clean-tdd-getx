import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Connectivity get connectivity;
  @lazySingleton
  LocalAuthentication get localAuthentication;

  @lazySingleton
  Dio dio() => Dio();
  @lazySingleton
  ImagePicker imagePicker() => ImagePicker();

  @preResolve // if you need to pre resolve the value
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
}
