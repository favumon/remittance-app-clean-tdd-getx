import 'package:core/error/failures.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/dashboard/quick_link/model/quick_link_item_model.dart';
import 'package:data/feature/dashboard/quick_link/model/quick_link_request_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class QuickLinkDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  QuickLinkDataSource({
    required this.remoteApi,
    required this.apiEndpoints,
  });

  Future<Either<Failure, List<QuickLinkModel>>> getQuickLink(
      QuickLinkRequestModel quickLinkRequestModel) async {
    var response = await remoteApi.apiGet(apiEndpoints.quickLink,
        queryParameters: quickLinkRequestModel.toJson());

    return response.fold((l) => Left(l), (r) {
      return Right((r as List)
          .map<QuickLinkModel>(
            (e) => QuickLinkModel.fromMap(e),
          )
          .toList());
    });
  }
}
