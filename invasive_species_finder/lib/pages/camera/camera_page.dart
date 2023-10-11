import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  static const routeName = '/camera';

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  bool isCameraReady = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller.initialize();
    if (!mounted) return;
    setState(() {
      isCameraReady = true;
    });
  }

  Future<void> takePicture() async {
    if (!controller.value.isTakingPicture) {
      final XFile image = await controller.takePicture();
      // Handle the captured image as needed (e.g., display it or save it).
    }
  }

  XFile? image;

  Future<void> pickImageFromGallery() async {
    final XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
      // Handle the selected image as needed (e.g., display it or save it).
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 40.0),
            Column(
              children: <Widget>[
                // You can replace this with your own image asset.
                Image.asset('assets/images/camera_icon.png', width: 200),
                const SizedBox(height: 16.0),
                Text(
                  "Camera and Gallery",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: takePicture,
              child: const Text('Take Picture'),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: pickImageFromGallery,
              child: const Text('Pick Image from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
