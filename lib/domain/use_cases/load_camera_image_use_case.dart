import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class LoadCameraImageUseCase {
  Future<Uint8List> load() async {
    return ImagePicker()
        .getImage(source: ImageSource.camera)
        .then((image) => image.readAsBytes())
        .catchError((e) => null);
  }
}
