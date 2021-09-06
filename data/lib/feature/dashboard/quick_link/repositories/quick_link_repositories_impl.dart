import 'package:core/error/failures.dart';
import 'package:data/feature/dashboard/quick_link/data_sources/quick_link_data_source.dart';
import 'package:data/feature/dashboard/quick_link/model/quick_link_request_model.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_request.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_item.dart';
import 'package:domain/feature/dashboard/quick_link/repositories/quick_link_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: QuickLinkRepository)
class QuickLinkRepositoriesImpl extends QuickLinkRepository {
  final QuickLinkDataSource _quickLinkDataSource;

  QuickLinkRepositoriesImpl(this._quickLinkDataSource);

  @override
  Future<Either<Failure, List<QuickLinkItem>>> getQuickLink(
      QuickLinkRequest quickLinkRequest) {
    return _quickLinkDataSource.getQuickLink(QuickLinkRequestModel());
  }
}
