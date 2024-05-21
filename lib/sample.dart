import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async'; // for simulating a delay

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageCaptureScreen(),
    );
  }
}

class ImageCaptureScreen extends StatefulWidget {
  @override
  _ImageCaptureScreenState createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  bool _isLoading = false;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      // Simulate image processing delay
      await processImage(File(pickedFile.path));

      setState(() {
        _image = File(pickedFile.path);
        _isLoading = false;
      });
    }
  }

  Future<void> processImage(File image) async {
    // Simulating a delay for image processing
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Capture and Processing'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_image == null)
              Text('No image selected.')
            else
              Image.file(_image!),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'Capture Image',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
