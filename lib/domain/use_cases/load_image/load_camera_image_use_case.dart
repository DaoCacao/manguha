import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LoadCameraImageUseCase {
  Future<File> load() async {
    return ImagePicker()
        .getImage(source: ImageSource.camera)
        .then((image) => image.readAsBytes())
        .then(_createFile)
        .catchError((e) => null);
  }

  Future<File> _createFile(Uint8List bytes) {
    return getApplicationSupportDirectory()
        .then((dir) => join(dir.path, DateTime.now().toString()))
        .then((path) => File(path))
        .then((file) => file.writeAsBytes(bytes));
  }
}
