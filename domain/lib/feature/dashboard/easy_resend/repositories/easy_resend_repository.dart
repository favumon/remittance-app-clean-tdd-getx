import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_item.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_request.dart';

abstract class EasyResendRepository {
  Future<Either<Failure, List<EasyResendItem>>> getEasyResend(
      EasyResendRequest easyResendRequest);
}
