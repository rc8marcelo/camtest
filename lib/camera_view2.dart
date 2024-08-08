import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraView2 extends StatefulWidget {
  const CameraView2({super.key});

  @override
  State<CameraView2> createState() => _CameraView2State();
}

class _CameraView2State extends State<CameraView2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> setup() async {
    if (await Permission.photos.request().isGranted &&
        await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      final ImagePicker picker = ImagePicker();
      // Capture a photo.
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    }
  }

  Future<void> setup2() async {
    if (await Permission.photos.request().isGranted &&
        await Permission.camera.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      final ImagePicker picker = ImagePicker();
      // Pick an image.
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              setup();
            },
            child: const Text('Open Camera'),
          ),
          TextButton(
            onPressed: () {
              setup2();
            },
            child: const Text('Open Gallery'),
          ),
        ],
      ),
    );
  }
}
