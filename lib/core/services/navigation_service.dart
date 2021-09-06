import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NavigationService {
  final GetInterface get;

  NavigationService(this.get);

  Future<dynamic>? navigate(String route, {dynamic arguments}) {
    return get.toNamed(route, arguments: arguments);
  }

  void navigateAndReplace(String route, {dynamic arguments, dynamic result}) {
    get.offAndToNamed(route, arguments: arguments, result: result);
  }

  void navigateBackUntil(String route) {
    get.until((r) => r.settings.name == route);
  }

  void navigateAndClearStackUntil(String route,
      {bool Function(Route<dynamic>)? predicate}) {
    get.offAllNamed(route, predicate: predicate);
  }

  void navigateBack() {
    get.back();
  }
}
