import 'package:core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_request.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_item.dart';

abstract class QuickLinkRepository {
  Future<Either<Failure, List<QuickLinkItem>>> getQuickLink(
      QuickLinkRequest quickLinkRequest);
}
