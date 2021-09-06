import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionResponse { granted, denied, permenentlyDenied }

@lazySingleton
class PermissionHelper {
  PermissionHelper();

  Future<PermissionResponse> requestPhotoPermission() async {
    var status = await Permission.photos.request();
    switch (status) {
      case PermissionStatus.granted:
        return PermissionResponse.granted;
      case PermissionStatus.permanentlyDenied:
        Future.delayed(Duration(seconds: 2)).then((value) => openAppSettings());
        return PermissionResponse.permenentlyDenied;
      default:
        return PermissionResponse.denied;
    }
  }
}
