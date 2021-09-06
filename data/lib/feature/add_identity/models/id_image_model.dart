import 'package:domain/feature/add_identity/entities/id_image.dart';

class IdImageModel extends IdImage {
  final String imagePath;
  final String imageName;

  IdImageModel(this.imagePath, this.imageName) : super(imagePath, imagePath);
}
