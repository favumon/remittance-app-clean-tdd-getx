import 'package:domain/core/validation_params.dart';

class LastNameValidation extends ValidationParams {
  @override
  bool? get isRequired => true;
  @override
  int? get maxLength => 20;
}
