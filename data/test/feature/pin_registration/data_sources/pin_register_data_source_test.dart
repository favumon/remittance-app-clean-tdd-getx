import 'package:data/core/device/local_storage.dart';
import 'package:data/feature/pin_registration/data_sources/pin_register_data_source.dart';
import 'package:data/feature/pin_registration/models/pin_info_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pin_register_data_source_test.mocks.dart';

@GenerateMocks([LocalStorage])
main() {
  late PinRegisterDataSource pinRegisterDataSource;
  late MockLocalStorage mockLocalStorage;
  setUp(() {
    mockLocalStorage = MockLocalStorage();
    pinRegisterDataSource = PinRegisterDataSource(mockLocalStorage);
  });
  test('should call saveString on LocalStorage with PIN', () async {
    final pin = '1234';
    final pinInfo = PinInfoModel(pin);

    when(mockLocalStorage.saveString(loginPin, pin))
        .thenAnswer((realInvocation) => Future.value(true));

    await pinRegisterDataSource.savePin(pinInfo);

    verify(mockLocalStorage.saveString(loginPin, pin));
    verifyNoMoreInteractions(mockLocalStorage);
  });
}
