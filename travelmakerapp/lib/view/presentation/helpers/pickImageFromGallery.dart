import 'package:image_picker/image_picker.dart';
import 'dart:io';

final ImagePicker picker = ImagePicker();

Future<File?> pickImageFromGallery() async {
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  File? _image;
  if (pickedFile != null) {
    _image = File(pickedFile.path);
    return _image;
  } else{
    return null;
  }

}
