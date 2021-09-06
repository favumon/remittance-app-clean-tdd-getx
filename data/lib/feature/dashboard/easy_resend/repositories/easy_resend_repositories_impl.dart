import 'package:core/error/failures.dart';
import 'package:data/feature/dashboard/easy_resend/data_sources/easy_resend_data_source.dart';
import 'package:data/feature/dashboard/easy_resend/model/easy_resend_request_model.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_item.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_request.dart';
import 'package:domain/feature/dashboard/easy_resend/repositories/easy_resend_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EasyResendRepository)
class EasyResendRepositoriesImpl extends EasyResendRepository {
  final EasyResendtDataSource _easyResendDataSource;

  EasyResendRepositoriesImpl(this._easyResendDataSource);

  @override
  Future<Either<Failure, List<EasyResendItem>>> getEasyResend(
      EasyResendRequest easyResendRequest) {
    return _easyResendDataSource.getEasyResend(EasyResendRequestModel());
  }
}
