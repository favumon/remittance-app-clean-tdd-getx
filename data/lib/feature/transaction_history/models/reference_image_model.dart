import 'package:domain/feature/transaction_history/entities/reference_image.dart';

class ReferenceImageModel extends ReferenceImage {
  final String imageName;
  final String imagePath;
  ReferenceImageModel(this.imagePath, this.imageName)
      : super(
          imageName: imageName,
          imagePath: imagePath,
        );
}
