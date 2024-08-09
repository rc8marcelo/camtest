import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum ImageSourceType { camera, gallery }

class CameraView2 extends StatefulWidget {
  const CameraView2({super.key});

  @override
  State<CameraView2> createState() => _CameraView2State();
}

class _CameraView2State extends State<CameraView2> {
  Future<void> savePhoto(XFile photo) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = File('$path/$fileName');
    await file.writeAsBytes(await photo.readAsBytes());
    await listFiles();
    setState(() {});
  }

  Future<void> setup(ImageSourceType sourceType) async {
    if (await Permission.photos.request().isGranted &&
        await Permission.camera.request().isGranted) {
      final ImagePicker picker = ImagePicker();
      XFile? photo;
      if (sourceType == ImageSourceType.camera) {
        photo = await picker.pickImage(source: ImageSource.camera);
      } else if (sourceType == ImageSourceType.gallery) {
        photo = await picker.pickImage(source: ImageSource.gallery);
      }
      if (photo != null) {
        await savePhoto(photo);
      }
    }
  }

  Future<List<FileSystemEntity>> listFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final dir = Directory(path);
    return dir.listSync();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setup(ImageSourceType.camera);
              },
              child: const Text('Open Camera'),
            ),
            TextButton(
              onPressed: () {
                setup(ImageSourceType.gallery);
              },
              child: const Text('Open Gallery'),
            ),
            Expanded(
              child: FutureBuilder<List<FileSystemEntity>>(
                future: listFiles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No files found'));
                  } else {
                    final files = snapshot.data!;
                    return ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];
                        return ListTile(
                          title: Text(file.path.split('/').last),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FileViewer(file: file),
                              ),
                            ).then(
                              (_) async {
                                await listFiles();
                                setState(() {});
                              },
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileViewer extends StatelessWidget {
  final FileSystemEntity file;

  const FileViewer({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.path.split('/').last),
      ),
      body: Center(
        child: Image.file(File(file.path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          file.delete();
        },
        child: const Icon(Icons.delete),
      ),
    );
  }
}
