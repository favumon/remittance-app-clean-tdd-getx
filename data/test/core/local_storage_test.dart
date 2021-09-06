import 'package:data/core/device/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_test.mocks.dart';

@GenerateMocks([SharedPreferences])
main() {
  MockSharedPreferences? mockSharedPreferences;
  LocalStorage? localStorageImpl;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localStorageImpl = LocalStorage(mockSharedPreferences!);
  });
  test('shoud call SharedPreferences to save value', () {
    var testReturnValue = 'test';
    when(mockSharedPreferences?.getString(any)).thenReturn(testReturnValue);
    localStorageImpl?.getString('');
    verify(mockSharedPreferences?.getString(any));
  });

  test('shoud return value if exists', () {
    var testReturnValue = 'test';
    when(mockSharedPreferences?.getString(any)).thenReturn(testReturnValue);
    var result = localStorageImpl?.getString('');
    verify(mockSharedPreferences?.getString(any));
    expect(result, testReturnValue);
  });

  test('shoud return null if not exist', () {
    when(mockSharedPreferences?.getString(any)).thenReturn(null);
    var result = localStorageImpl?.getString('');
    verify(mockSharedPreferences?.getString(any));
    expect(result, null);
  });

  test('shoud return value if exists', () {
    when(mockSharedPreferences?.getBool(any)).thenReturn(null);
    var result = localStorageImpl?.getBool('');
    verify(mockSharedPreferences?.getBool(any));
    expect(result, null);
  });

  test('shoud return null if not exist', () {
    when(mockSharedPreferences?.getBool(any)).thenReturn(null);
    var result = localStorageImpl?.getBool('');
    verify(mockSharedPreferences?.getBool(any));
    expect(result, null);
  });
}
