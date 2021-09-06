import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/device/image_picker.dart';
import 'package:data/core/device/permission_helper.dart';
import 'package:data/core/models/common_api_response_model.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/add_identity/models/id_image_model.dart';
import 'package:data/feature/add_identity/models/id_type_model.dart';
import 'package:data/feature/add_identity/models/identity_data_model.dart';
import 'package:data/feature/add_identity/models/nationality_model.dart';
import 'package:data/feature/add_identity/models/signature_image_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddIdentityDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;
  final ImagePicker imagePicker;
  final PermissionHelper permissionHelper;

  AddIdentityDataSource(
    this.remoteApi,
    this.apiEndpoints,
    this.imagePicker,
    this.permissionHelper,
  );

  Future<Either<Failure, List<NationalityModel>>> getNationalities() async {
    var response = await remoteApi.apiGet(apiEndpoints.identityNationalities);

    return response.fold(
        (l) => Left(l),
        (r) => Right(List<NationalityModel>.from(
            r.map((x) => NationalityModel.fromJson(x)))));
  }

  Future<Either<Failure, List<IdTypeModel>>> getIdTypes() async {
    var response = await remoteApi.apiGet(apiEndpoints.identityIdTypes);

    return response.fold(
        (l) => Left(l),
        (r) => Right(
            List<IdTypeModel>.from(r.map((x) => IdTypeModel.fromJson(x)))));
  }

  Future<Either<Failure, IdImageModel>> getIdImage() async {
    final permisionStatus = await permissionHelper.requestPhotoPermission();
    if (permisionStatus != PermissionResponse.granted)
      return Left(PhotoAccessPermissionFailure(
          isPermenetlyDenied:
              permisionStatus == PermissionResponse.permenentlyDenied));

    var image = await imagePicker.pickImageFromGallery();
    if (image != null)
      return Right(IdImageModel(image.path, image.path.split('/').last));

    return Left(ImagePickFailure());
  }

  Future<Either<Failure, SignatureImageModel>> getSignatureImage() async {
    final permisionStatus = await permissionHelper.requestPhotoPermission();
    if (permisionStatus != PermissionResponse.granted)
      return Left(PhotoAccessPermissionFailure(
          isPermenetlyDenied:
              permisionStatus == PermissionResponse.permenentlyDenied));
    var image = await imagePicker.pickImageFromGallery();
    if (image != null) //return Right(model);
      return Right(SignatureImageModel(image.path, image.path.split('/').last));

    return Left(ImagePickFailure());
  }

  Future<Either<Failure, CommonApiResponseModel>> addIdentity(
      {required IdentityDataModel request}) async {
    var response = await remoteApi.apiPost(apiEndpoints.addIdentity,
        data: await request.toFormData());

    return response.fold(
        (l) => Left(l), (r) => Right(CommonApiResponseModel.fromMap(r)));
  }
}
