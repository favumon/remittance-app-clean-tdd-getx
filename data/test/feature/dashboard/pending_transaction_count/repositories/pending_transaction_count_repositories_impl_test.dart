import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:data/feature/dashboard/pending_transaction_count/data_sources/pending_transaction_count_data_source.dart';
import 'package:data/feature/dashboard/pending_transaction_count/model/pending_transaction_count_item_model.dart';
import 'package:data/feature/dashboard/pending_transaction_count/model/pending_transaction_count_request_model.dart';
import 'package:data/feature/dashboard/pending_transaction_count/repositories/pending_transaction_count_repositories_impl.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_item.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_request.dart';

import 'pending_transaction_count_repositories_impl_test.mocks.dart';

@GenerateMocks([PendingTransactionCountDataSource])
main() {
  late MockPendingTransactionCountDataSource
      mockPendingTransactionCountDataSource;

  late PendingTransactionCountRepositoriesImpl
      pendingTransactionCountRepositoriesImpl;

  setUp(() {
    mockPendingTransactionCountDataSource =
        MockPendingTransactionCountDataSource();
    pendingTransactionCountRepositoriesImpl =
        PendingTransactionCountRepositoriesImpl(
            mockPendingTransactionCountDataSource);
  });

  test(
      'should get PendingTransactionCountItem from PendingTransactionCountDataSource',
      () async {
    final requestModel = PendingTransactionCountRequestModel();
    final PendingTransactionCountRequest request = requestModel;
    final itemModel = PendingTransactionCountModel(pendingTransactionCount: 1);
    final PendingTransactionCountItem item = itemModel;

    when(mockPendingTransactionCountDataSource
            .getPendingTransactionCount(requestModel))
        .thenAnswer((realInvocation) => Future.value(Right(itemModel)));

    var result = await pendingTransactionCountRepositoriesImpl
        .getPendingTransactionCount(request);

    expect(result, Right(item));

    verify(mockPendingTransactionCountDataSource
        .getPendingTransactionCount(requestModel));
    verifyNoMoreInteractions(mockPendingTransactionCountDataSource);
  });
}
