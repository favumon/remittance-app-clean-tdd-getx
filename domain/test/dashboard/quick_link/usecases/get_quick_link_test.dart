import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/dashboard/quick_link/usecases/get_quick_link.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_item.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_request.dart';
import 'package:domain/feature/dashboard/quick_link/repositories/quick_link_repository.dart';

import 'get_quick_link_test.mocks.dart';

@GenerateMocks([QuickLinkRepository])
main() {
  late MockQuickLinkRepository mockQuickLinkRepository;
  late GetQuickLink getQuickLink;

  setUp(() {
    mockQuickLinkRepository = MockQuickLinkRepository();
    getQuickLink = GetQuickLink(mockQuickLinkRepository);
  });

  test('should get list of QuickLinkItem from QuickLinkRepository', () async {
    final request = QuickLinkRequest();
    final params = GetQuickLinkParams();
    final response = [QuickLinkItem(beneficiaryId: '1', beneficiaryName: '')];

    when(mockQuickLinkRepository.getQuickLink(request))
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    var result = await getQuickLink(params);

    verify(mockQuickLinkRepository.getQuickLink(request));

    expect(result, Right(response));
  });
}
