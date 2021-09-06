import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:data/feature/dashboard/quick_link/data_sources/quick_link_data_source.dart';
import 'package:data/feature/dashboard/quick_link/model/quick_link_item_model.dart';
import 'package:data/feature/dashboard/quick_link/model/quick_link_request_model.dart';
import 'package:data/feature/dashboard/quick_link/repositories/quick_link_repositories_impl.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_item.dart';
import 'package:domain/feature/dashboard/quick_link/entity/quick_link_request.dart';

import 'quick_link_repositories_impl_test.mocks.dart';

@GenerateMocks([QuickLinkDataSource])
main() {
  late MockQuickLinkDataSource mockQuickLinkDataSource;
  late QuickLinkRepositoriesImpl quickLinkRepositoriesImpl;

  setUp(() {
    mockQuickLinkDataSource = MockQuickLinkDataSource();
    quickLinkRepositoriesImpl =
        QuickLinkRepositoriesImpl(mockQuickLinkDataSource);
  });

  test('should get list of QuickLinkItem from QuickLinkDataSource', () async {
    final itemModel = [
      QuickLinkModel(beneficiaryName: 'A', beneficiaryId: '1')
    ];
    final List<QuickLinkItem> item = itemModel;

    final requestModel = QuickLinkRequestModel();
    final QuickLinkRequest request = requestModel;

    when(mockQuickLinkDataSource.getQuickLink(requestModel))
        .thenAnswer((realInvocation) => Future.value(Right(itemModel)));

    var result = await quickLinkRepositoriesImpl.getQuickLink(request);

    expect(result, Right(item));

    verify(mockQuickLinkDataSource.getQuickLink(requestModel));
    verifyNoMoreInteractions(mockQuickLinkDataSource);
  });
}
