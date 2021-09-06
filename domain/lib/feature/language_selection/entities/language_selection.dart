import 'package:equatable/equatable.dart';

class LanguageSelection extends Equatable {
  final String language;
  final bool isSelected;

  LanguageSelection({required this.language, required this.isSelected});

  @override
  List<Object?> get props => [language, isSelected];
}
