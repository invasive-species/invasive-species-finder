import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _controller;
  List<CameraDescription> cameras;
  String imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 300,
              width: 300,
              child: _cameraPreviewWidget(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _takePicture();
              },
              child: Text('Take Picture'),
            ),
            SizedBox(height: 20),
            imagePath != null
                ? Image.file(
                    File(imagePath),
                    height: 200,
                    width: 200,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    if (_controller == null || !_controller.value.isInitialized) {
      return Center(
        child: Text('Camera is not available'),
      );
    } else {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller),
      );
    }
  }

  Future<void> _takePicture() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String picturePath =
        join(appDirectory.path, 'assets/images/picture.jpg');

    try {
      await _controller.takePicture(picturePath);
      setState(() {
        imagePath = picturePath;
      });
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
