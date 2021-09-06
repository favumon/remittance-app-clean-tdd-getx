import 'package:equatable/equatable.dart';

class SliderItem extends Equatable {
  final String title;
  final String desc;
  final String imagePath;

  SliderItem({required this.title, this.desc = '', required this.imagePath});

  @override
  List<Object?> get props => [
        title,
        desc,
        imagePath,
      ];
}
