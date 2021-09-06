import 'package:data/feature/add_identity/models/nationality_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([])
main() {
  setUp(() {});
  test(
    'should return a JSON map containing the proper nationality',
    () async {
      final nationalityId = 1;
      final nationalityName = 'Nation';
      final model = NationalityModel(
          nationalityId: nationalityId, nationalityName: nationalityName);
      final result = model.toJson();
      final expectedMap = {
        "nationality_id": nationalityId,
        "nationality_name": nationalityName,
      };
      expect(result, expectedMap);
    },
  );
}
