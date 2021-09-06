import 'package:equatable/equatable.dart';

class TermsAndConditions extends Equatable {
  final String termsAndConditionsText;

  TermsAndConditions(this.termsAndConditionsText);

  @override
  List<Object?> get props => [termsAndConditionsText];
}
