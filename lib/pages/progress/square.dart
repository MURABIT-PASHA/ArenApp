import 'dart:io';
import 'package:arenapp/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:arenapp/components/image_list_widget.dart';
import 'package:arenapp/external/image_cropper/image_cropper.dart';

class SquarePage extends StatefulWidget {
  static const String fromGallery = 'square_page_gallery';
  static const String fromCamera = 'square_page_camera';
  final bool isGallery;
  const SquarePage({Key? key, required this.isGallery}) : super(key: key);

  @override
  State<SquarePage> createState() => _SquarePageState();
}

class _SquarePageState extends State<SquarePage> {
  static List<File> imageFiles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resim Seç"),
      ),
      //Seçili ve kırpılmış resimlerin olduğu gövde
      body: ImageListWidget(
        imageFiles: imageFiles,
      ),
      //Ekle butonu
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade700,
        onPressed: () {
          //İlk kez basılsın
          onPressedButton();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future onPressedButton() async {
    //Daha önce oluşturduğumuz Utils sınıfının sonucu olarak bir file oluşuyor
    try {
      final file = await Utils.pickMedia(
          isGallery: widget.isGallery, cropImage: cropSquareImage);
      setState(() {
        imageFiles.add(file);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<File> cropSquareImage(File imageFile) async {
    try {
      final croppedImage = (await ImageCropper.platform.cropImage(
          sourcePath: imageFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [CropAspectRatioPreset.square],
          compressQuality: 70,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [AndroidUiSettings(toolbarTitle: "Resmi Kırp",toolbarColor: Colors.green.shade700),],)
      );
      return croppedImage;
    } catch (e) {
      throw (e);
    }
  }
}
