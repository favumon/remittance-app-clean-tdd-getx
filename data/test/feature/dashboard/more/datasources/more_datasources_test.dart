import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:data/feature/dashboard/more/datasources/more_datasources.dart';

@GenerateMocks([])
main() {
  late MoreDatasource moreDatasource;

  setUp(() {
    moreDatasource = MoreDatasource();
  });

  test('should return Null ', () {
    //TODO
  });
}
