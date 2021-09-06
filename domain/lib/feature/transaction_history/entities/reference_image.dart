import 'package:equatable/equatable.dart';

class ReferenceImage extends Equatable {
  final String imageName;
  final String imagePath;

  ReferenceImage({required this.imageName, required this.imagePath});

  @override
  List<Object?> get props => [imageName, imagePath];
}
