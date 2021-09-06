import 'package:domain/core/validation_params.dart';

class UserNameValidation extends ValidationParams {
  @override
  final bool? isRequired = true;
  @override
  int? get maxLength => 20;
  @override
  int? get minLength => 4;
}
