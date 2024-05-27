import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';


import 'package:image/image.dart' as img;
import 'dart:math' as math;
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image to UTF-8 Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageConverter(),
    );
  }
}

class ImageConverter extends StatefulWidget {
  @override
  _ImageConverterState createState() => _ImageConverterState();
}

class _ImageConverterState extends State<ImageConverter> {
  final ImagePicker _picker = ImagePicker();
  String? _utf8ImageString;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      File waterMarkedImage = await processImageInIsolate(image.path);
      final utf8String = await _convertImageToUtf8(waterMarkedImage.path);
      setState(() {
        _utf8ImageString = utf8String;
      });
    }
  }

  Future<String> _convertImageToUtf8(String imagePath) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();
    final base64String = base64Encode(bytes);
    final utf8String = utf8.decode(base64String.codeUnits);
    return utf8String;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image to UTF-8 Converter'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image from Camera'),
              ),
              if (_utf8ImageString != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'UTF-8 Encoded Image String:\n$_utf8ImageString',
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<File> processImageInIsolate(String imagePath) async {


    try {
      // Get the current date and time
      // Get the current date and time
      DateTime now = DateTime.now();
      String formattedDateTime =
          "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}";

      // Read the original image
      File file = File(imagePath);
      List<int> imageBytes = file.readAsBytesSync();
      img.Image? originalImage =
      img.decodeImage(Uint8List.fromList(imageBytes));

      // Scale the image to adjust the font size
      double scaleFactor = calculateScaleFactor(
          originalImage); // Adjust the scale factor as needed
      img.Image resizedImage = img.copyResize(originalImage!,
          width: (originalImage.width * scaleFactor).round());

      // Add watermark text
      img.drawString(resizedImage, img.arial_48, 20, 20, formattedDateTime,
          color: img.getColor(255, 0, 0));

      // Create a new File for the watermarked image
      String outputImagePath = imagePath.replaceAll('.jpg',
          '_watermarked.png'); // Customize the output file name if needed
      File watermarkedFile = File(outputImagePath);

      // Save the watermarked image
      watermarkedFile.writeAsBytesSync(img.encodeJpg(resizedImage));
      // sendPort.send({'outputImagePath': outputImagePath});
      return watermarkedFile;
    } catch (e) {
      // sendPort.send({'error': e.toString()});
      showToastMessage(e.toString());
      return File("");
    }
  }


  static double calculateScaleFactor(img.Image? image) {
    if (image != null) {
      // Determine the desired width or height for resizing (you can adjust this as needed)
      double targetWidth = 700; // Adjust to your desired width

      // Calculate the scale factor based on the aspect ratio and the target width
      double scaleFactor = targetWidth / image.width;

      // Ensure that the scale factor is within a reasonable range
      scaleFactor = math.max(scaleFactor, 0.1); // Minimum scale factor
      scaleFactor = math.min(scaleFactor, 2.0); // Maximum scale factor

      return scaleFactor;
    }

    return 0.5;
  }


}
