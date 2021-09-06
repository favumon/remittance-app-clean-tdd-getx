import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:domain/feature/dashboard/pending_transaction_count/usecases/get_pending_transaction_count.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_item.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/entity/pending_transaction_count_request.dart';
import 'package:domain/feature/dashboard/pending_transaction_count/repositories/pending_transaction_count_repository.dart';

import 'get_pending_transaction_count_test.mocks.dart';

@GenerateMocks([PendingTransactionCountRepository])
main() {
  late MockPendingTransactionCountRepository
      mockPendingTransactionCountRepository;
  late GetPendingTransactionCount getPendingTransactionCount;

  setUp(() {
    mockPendingTransactionCountRepository =
        MockPendingTransactionCountRepository();
    getPendingTransactionCount =
        GetPendingTransactionCount(mockPendingTransactionCountRepository);
  });

  test(
      'should get PendingTransactionCountItem from PendingTransactionCountRepository',
      () async {
    final params = GetPendingTransactionCountParams();
    final request = PendingTransactionCountRequest();
    final response = PendingTransactionCountItem(pendingTransactionCount: 1);

    when(mockPendingTransactionCountRepository
            .getPendingTransactionCount(request))
        .thenAnswer((realInvocation) => Future.value(Right(response)));

    var result = await getPendingTransactionCount(params);

    verify(mockPendingTransactionCountRepository
        .getPendingTransactionCount(request));

    expect(result, Right(response));
  });
}
