import 'package:domain/core/validation_params.dart';

class MiddleNameValidation extends ValidationParams {
  @override
  bool? get isRequired => false;
  @override
  int? get maxLength => 20;
}
