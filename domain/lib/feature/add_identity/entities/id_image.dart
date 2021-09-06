import 'package:equatable/equatable.dart';

class IdImage extends Equatable {
  final String imagePath;
  final String imageName;

  IdImage(this.imagePath, this.imageName);

  @override
  String toString() {
    return 'ID Image';
  }

  @override
  List<Object?> get props => [this.imagePath, this.imageName];
}
