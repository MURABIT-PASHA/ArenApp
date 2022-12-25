import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Utils{
  static Future<File> pickMedia({required bool isGallery, required Future<File> Function(File file) cropImage}) async{
    try {
      final source = isGallery ? ImageSource.gallery : ImageSource.camera;
      final pickedFile = await ImagePicker().pickImage(source: source);
      if(pickedFile == null){
        return File("dosya secilmedi");
      }
      else{
        if (cropImage == null){
          return File(pickedFile.path);
        }
        else{
          final file = File(pickedFile.path);
          return cropImage(file);
        }
      }
    } on Exception catch (e) {
      return File("dosyaya ulasılamadı");
    }
  }
}