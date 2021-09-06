import 'package:core/error/failures.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/remote_api.dart';
import 'package:dartz/dartz.dart';
import 'package:data/feature/dashboard/pending_transaction_count/model/pending_transaction_count_item_model.dart';
import 'package:data/feature/dashboard/pending_transaction_count/model/pending_transaction_count_request_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PendingTransactionCountDataSource {
  final RemoteApi remoteApi;
  final ApiEndpoints apiEndpoints;

  PendingTransactionCountDataSource({
    required this.remoteApi,
    required this.apiEndpoints,
  });

  Future<Either<Failure, PendingTransactionCountModel>>
      getPendingTransactionCount(
          PendingTransactionCountRequestModel
              pendingTransactionCountRequestModel) async {
    var response = await remoteApi.apiGet(apiEndpoints.pendingTransactionCount,
        queryParameters: pendingTransactionCountRequestModel.toJson());

    return response.fold(
        (l) => Left(l), (r) => Right(PendingTransactionCountModel.fromMap(r)));
  }
}
