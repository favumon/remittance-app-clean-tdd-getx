import 'package:data/feature/add_identity/models/id_type_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([])
main() {
  setUp(() {});
  test(
    'should return a JSON map containing the proper did types',
    () async {
      final idTypeId = 1;
      final idTypeName = 'IdTypeName';
      final model = IdTypeModel(idTypeId: idTypeId, idTypeName: idTypeName);
      final result = model.toJson();
      final expectedMap = {
        "id_type_id": idTypeId,
        "id_type_name": idTypeName,
      };
      expect(result, expectedMap);
    },
  );
}
