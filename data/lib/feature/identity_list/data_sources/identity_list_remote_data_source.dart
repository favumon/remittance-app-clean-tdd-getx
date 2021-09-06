import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/device/image_picker.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/identity_list/models/identity_detail_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class IdentityListRemoteDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;
  final ImagePicker imagePicker;

  IdentityListRemoteDataSource(
      this.remoteApi, this.apiEndpoints, this.imagePicker);

  Future<Either<Failure, List<IdentityDetailModel>>> getIdentityList() async {
    var response = await remoteApi.apiGet(apiEndpoints.userIdentities);

    return response.fold(
        (l) => Left(l),
        (r) => Right(List<IdentityDetailModel>.from(
            r.map((x) => IdentityDetailModel.fromJson(x)))));
  }
}
