import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_painter/image_painter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageEditorPage extends StatefulWidget {
  const ImageEditorPage({Key? key}) : super(key: key);

  @override
  ImageEditorPageState createState() => ImageEditorPageState();
}

class ImageEditorPageState extends State<ImageEditorPage> {
  final _imageKey = GlobalKey<ImagePainterState>();
  final _key = GlobalKey<ScaffoldState>();
  late File _image;
  bool _isImagePicked = false;
  final picker = ImagePicker();
  Future<bool> _requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.denied ||
        status == PermissionStatus.restricted) {
      var storagePermission = await Permission.storage.request();
      if (storagePermission.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> _checkPermission() async {
    final preference = await SharedPreferences.getInstance();
    bool storagePermission =
        preference.getBool('isStoragePermissionGranted') ?? false;
    if (storagePermission) {
      return;
    } else {
      preference.setBool(
          'isStoragePermissionGranted', await _requestStoragePermission());
      return;
    }
  }

  void saveImage() async {
    final image = await _imageKey.currentState?.exportImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    await Directory('$directory/sample').create(recursive: true);
    final fullPath =
        '$directory/sample/${DateTime.now().millisecondsSinceEpoch}.png';
    final imgFile = File(fullPath);
    imgFile.writeAsBytesSync(image!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[700],
        padding: const EdgeInsets.only(left: 10),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Image Exported successfully.",
                style: TextStyle(color: Colors.white)),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (builder) => Image.file(imgFile));
              },
              child: Text(
                "Open",
                style: TextStyle(
                  color: Colors.blue[200],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _isImagePicked = true;
      setState(() {});
    } else {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Image did not pick')));
      });
    }
  }

  @override
  void initState() {
    _checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("Image Converter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: saveImage,
          )
        ],
      ),
      body: _isImagePicked
          ? ImagePainter.file(
              _image,
              key: _imageKey,
              scalable: true,
              initialStrokeWidth: 2,
              textDelegate: TextDelegate(),
              initialColor: Colors.red,
              initialPaintMode: PaintMode.freeStyle,
            )
          : Container(
              margin: const EdgeInsets.all(25),
              child: DottedBorder(
                  child: GestureDetector(
                onTap: _pickImage,
              )),
            ),
    );
  }
}
