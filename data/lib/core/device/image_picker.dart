import 'package:image_picker/image_picker.dart' as picker;
import 'package:injectable/injectable.dart';

@lazySingleton
class ImagePicker {
  final picker.ImagePicker imagePicker;

  ImagePicker(this.imagePicker);

  Future<dynamic> pickImageFromGallery() async {
    return await imagePicker.getImage(source: picker.ImageSource.gallery);
  }
}
