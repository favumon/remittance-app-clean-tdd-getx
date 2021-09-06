import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_item.dart';
import 'package:domain/feature/dashboard/easy_resend/entity/easy_resend_request.dart';
import 'package:domain/feature/dashboard/easy_resend/repositories/easy_resend_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetEasyResend extends UseCase<List<EasyResendItem>, GetEasyResendParams> {
  final EasyResendRepository _easyResendRepository;

  GetEasyResend(this._easyResendRepository);

  @override
  Future<Either<Failure, List<EasyResendItem>>> call(
      GetEasyResendParams params) async {
    return await _easyResendRepository.getEasyResend(EasyResendRequest());
  }
}

class GetEasyResendParams extends Equatable {
  GetEasyResendParams();

  @override
  List<Object?> get props => [];
}
