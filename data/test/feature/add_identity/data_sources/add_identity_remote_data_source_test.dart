import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:data/core/constants/api_endpoints.dart';
import 'package:data/core/device/image_picker.dart';
import 'package:data/core/device/permission_helper.dart';
import 'package:data/core/mock_api_responses/mock_response_reader.dart';
import 'package:data/core/models/common_api_response_model.dart';
import 'package:data/core/remote_api.dart';
import 'package:data/feature/add_identity/data_sources/add_identity_remote_data_source.dart';
import 'package:data/feature/add_identity/models/id_image_model.dart';
import 'package:data/feature/add_identity/models/id_type_model.dart';
import 'package:data/feature/add_identity/models/identity_data_model.dart';
import 'package:data/feature/add_identity/models/nationality_model.dart';
import 'package:data/feature/add_identity/models/signature_image_model.dart';
import 'package:domain/feature/add_identity/entities/id_type.dart';
import 'package:domain/feature/add_identity/entities/nationality.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_identity_remote_data_source_test.mocks.dart';

@GenerateMocks([RemoteApi, ApiEndpoints, ImagePicker, PermissionHelper])
main() {
  late MockRemoteApi mockRemoteApi;
  late ApiEndpoints mockApiEndpoints;
  late MockImagePicker mockImagePicker;
  late AddIdentityDataSource addIdentityDataSource;
  late MockPermissionHelper mockPermissionHelper;
  setUp(() {
    mockImagePicker = MockImagePicker();
    mockApiEndpoints = ApiEndpointsDev();
    mockRemoteApi = MockRemoteApi();
    mockPermissionHelper = MockPermissionHelper();

    addIdentityDataSource = AddIdentityDataSource(
        mockRemoteApi, mockApiEndpoints, mockImagePicker, mockPermissionHelper);
  });
  test('Should submit identity info to API and get response', () async {
    final int idType = 1;
    final String idNumber = '123456';
    final String expiryDate = '2001-08-15 00:00:00.000';
    final String idImage1Path = 'idImage1Path';
    final String idImage2Path = 'idImage2Path';
    final String idSignaturePath = 'idSignaturePath';
    final int nationality = 2;
    final String dateOfBirth = '2001-08-15 00:00:00.000';
    IdentityDataModel identityDataModel = IdentityDataModel(
        idType,
        idNumber,
        expiryDate,
        idImage1Path,
        idImage2Path,
        idSignaturePath,
        nationality,
        dateOfBirth);
    when(mockRemoteApi.apiPost(mockApiEndpoints.addIdentity,
            data: anyNamed('data')))
        .thenAnswer((realInvocation) => Future.value(Right({})));

    var result =
        await addIdentityDataSource.addIdentity(request: identityDataModel);

    expect(result, Right(CommonApiResponseModel()));
  });

  test('Should get ID Image path from image picker', () async {
    final imagePath = 'path/imagename';

    final model = IdImageModel(imagePath, imagePath.split('/').last);

    when(mockImagePicker.pickImageFromGallery()).thenAnswer(
        (realInvocation) => Future.value(picker.PickedFile(imagePath)));

    var result = await addIdentityDataSource.getIdImage();
    expect(result, Right(model));
    verify(mockImagePicker.pickImageFromGallery());
  });

  test('Should get Signature path from image picker', () async {
    final signaturePath = 'path/imagename';

    final model =
        SignatureImageModel(signaturePath, signaturePath.split('/').last);

    when(mockImagePicker.pickImageFromGallery()).thenAnswer(
        (realInvocation) => Future.value(picker.PickedFile(signaturePath)));

    var result = await addIdentityDataSource.getSignatureImage();
    expect(result, Right(model));
    verify(mockImagePicker.pickImageFromGallery());
  });
  test('Should get IdTypes from API', () async {
    final map = jsonDecode(apiResposeMock('identity_id_types.json'));

    final idTypes =
        List<IdTypeModel>.from(map.map((x) => IdTypeModel.fromJson(x)));

    when(mockRemoteApi.apiGet(mockApiEndpoints.identityIdTypes))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await addIdentityDataSource.getIdTypes();
    result.fold((l) => null, (r) {
      expect(IdTypesWrapper(r), IdTypesWrapper(idTypes));
    });
    verify(mockRemoteApi.apiGet(mockApiEndpoints.identityIdTypes));
  });
  test('Should get Natinalities from API', () async {
    final map = jsonDecode(apiResposeMock('identity_nationalities.json'));

    final nationalities = List<NationalityModel>.from(
        map.map((x) => NationalityModel.fromJson(x)));

    when(mockRemoteApi.apiGet(mockApiEndpoints.identityNationalities))
        .thenAnswer((realInvocation) => Future.value(Right(map)));

    var result = await addIdentityDataSource.getNationalities();
    result.fold((l) => null, (r) {
      expect(NationalitiesWrapper(r), NationalitiesWrapper(nationalities));
    });
    verify(mockRemoteApi.apiGet(mockApiEndpoints.identityNationalities));
  });
}

class IdTypesWrapper extends Equatable {
  final List<IdType> idTypes;

  IdTypesWrapper(this.idTypes);

  @override
  List<Object?> get props => [idTypes];
}

class NationalitiesWrapper extends Equatable {
  final List<Nationality> nationalities;

  NationalitiesWrapper(this.nationalities);

  @override
  List<Object?> get props => [nationalities];
}
