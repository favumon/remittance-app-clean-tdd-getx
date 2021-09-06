import 'package:domain/feature/add_identity/entities/signature_image.dart';

class SignatureImageModel extends SignatureImage {
  final String imagePath;
  final String imageName;

  SignatureImageModel(this.imagePath, this.imageName)
      : super(imagePath, imagePath);
}
