import 'package:dartz/dartz.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_item.dart';
import 'package:domain/feature/dashboard/quick_link/usecases/get_quick_link.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remittance_app/core/services/navigation_service.dart';
import 'package:remittance_app/feature/dashboard/widget/quick_link/quick_link_controller.dart';

import 'quick_link_controller_test.mocks.dart';

@GenerateMocks([GetQuickLink, NavigationService])
main() {
  late MockGetQuickLink mockGetQuickLink;
  late MockNavigationService mockNavigationService;

  late QuickLinkController quickLinkController;

  setUp(() {
    mockGetQuickLink = MockGetQuickLink();
    mockNavigationService = MockNavigationService();

    quickLinkController =
        QuickLinkController(mockGetQuickLink, mockNavigationService);
  });

  test('should call GetQuickLink when initGetQuickLink called', () {
    final params = GetQuickLinkParams();

    when(mockGetQuickLink(params))
        .thenAnswer((realInvocation) => Future.value(Right(<QuickLinkItem>[])));

    quickLinkController.initGetQuickLink();

    verify(mockGetQuickLink(params));
  });
}
