import 'package:domain/core/validation_params.dart';

class ExpiryDateValidation extends ValidationParams {
  @override
  final bool? isRequired = true;
  final DateTime fromDate = DateTime.now();
  final DateTime toDate = DateTime.now().add(Duration(days: 364 * 10));
}
