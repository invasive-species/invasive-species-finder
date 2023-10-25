import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invasive_species_finder/pages/camera/take_picture_page.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  static const routeName = '/camera';

  Future<void> pickImageFromGallery() async {
    final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      // Handle the selected image as needed
    }
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
                Image.asset('assets/images/camera_icon.png', width: 200),
                const SizedBox(height: 16.0),
                Text(
                  "TAKE A PICTURE OR UPLOAD",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                Navigator.restorablePushNamed(
                  context,
                  TakePicturePage.routeName,
                );
              },
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
