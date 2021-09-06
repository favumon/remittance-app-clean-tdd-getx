import 'package:domain/feature/signup/entities/terms_and_conditions.dart';

class TermsAndConditionsModel extends TermsAndConditions {
  final String termsAndConditionsText;
  TermsAndConditionsModel({required this.termsAndConditionsText})
      : super(termsAndConditionsText);

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionsModel(
        termsAndConditionsText: json["t_and_c_text"],
      );
}
