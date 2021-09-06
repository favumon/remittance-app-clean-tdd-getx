import 'package:domain/core/validation_params.dart';

class DateOfBirthValidation extends ValidationParams {
  @override
  final bool? isRequired = true;
  final DateTime fromDate = DateTime.now().subtract(Duration(days: 364 * 120));
  final DateTime toDate = DateTime.now().subtract(Duration(days: 364 * 18));
}
