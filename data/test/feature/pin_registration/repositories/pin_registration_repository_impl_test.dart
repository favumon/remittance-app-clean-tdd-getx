import 'package:dartz/dartz.dart';
import 'package:data/feature/pin_registration/data_sources/pin_register_data_source.dart';
import 'package:data/feature/pin_registration/models/pin_info_model.dart';
import 'package:data/feature/pin_registration/repositories/pin_registration_repository_impl.dart';
import 'package:domain/feature/pin_registration/entities/pin_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pin_registration_repository_impl_test.mocks.dart';

@GenerateMocks([PinRegisterDataSource])
main() {
  late PinRegisterRepositoryImpl pinRegisterRepository;
  late MockPinRegisterDataSource mockPinRegisterDataSource;
  setUp(() {
    mockPinRegisterDataSource = MockPinRegisterDataSource();
    pinRegisterRepository =
        PinRegisterRepositoryImpl(mockPinRegisterDataSource);
  });
  test('should call savePin on PinRegisterDataSource with PIN', () async {
    final pin = '1234';
    final PinInfoModel model = PinInfoModel(pin);

    when(mockPinRegisterDataSource.savePin(model))
        .thenAnswer((realInvocation) => Future.value(Right(null)));
    await pinRegisterRepository.registerPin(PinInfoModel(pin));

    verify(mockPinRegisterDataSource.savePin(model));
  });
}
