import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_request.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_item.dart';
import 'package:domain/feature/dashboard/quick_link/repositories/quick_link_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetQuickLink extends UseCase<List<QuickLinkItem>, GetQuickLinkParams> {
  final QuickLinkRepository _quickLinkRepository;

  GetQuickLink(this._quickLinkRepository);

  @override
  Future<Either<Failure, List<QuickLinkItem>>> call(
      GetQuickLinkParams params) async {
    return await _quickLinkRepository.getQuickLink(QuickLinkRequest());
  }
}

class GetQuickLinkParams extends Equatable {
  GetQuickLinkParams();

  @override
  List<Object?> get props => [];
}
