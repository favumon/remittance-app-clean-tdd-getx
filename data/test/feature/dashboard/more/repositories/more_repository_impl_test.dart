import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:data/feature/dashboard/more/datasources/more_datasources.dart';
import 'package:data/feature/dashboard/more/models/signout_request_model.dart';
import 'package:data/feature/dashboard/more/repositories/more_repository_impl.dart';
import 'package:domain/feature/dashboard/more/entity/signout_request.dart';

import 'more_repository_impl_test.mocks.dart';

@GenerateMocks([MoreDatasource])
main() {
  late MockMoreDatasource mockMoreDatasource;
  late MoreRepositoryImpl moreRepositoryImpl;

  setUp(() {
    mockMoreDatasource = MockMoreDatasource();
    moreRepositoryImpl = MoreRepositoryImpl(mockMoreDatasource);
  });

  test('should get Null from MoreDatasource', () async {
    final requestModel = SignoutRequestModel();
    final SignoutRequest request = requestModel;

    when(mockMoreDatasource.signoutUser(requestModel))
        .thenAnswer((realInvocation) => Future.value(Right(null)));

    var result = await moreRepositoryImpl.signOutUser(request);

    expect(result, Right(null));

    verify(mockMoreDatasource.signoutUser(requestModel));
    verifyNoMoreInteractions(mockMoreDatasource);
  });
}
