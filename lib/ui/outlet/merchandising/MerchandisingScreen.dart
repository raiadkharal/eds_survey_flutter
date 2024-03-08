import 'dart:io';

import 'package:eds_survey/components/buttons/custom_button.dart';
import 'package:eds_survey/ui/market_visit/gandola/GandolaScreen.dart';
import 'package:eds_survey/ui/outlet/merchandising/MerchandisingListItem.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

import 'dart:typed_data';
import 'package:image/image.dart' as img;

class MerchandisingScreen extends StatefulWidget {
  const MerchandisingScreen({super.key});

  @override
  State<MerchandisingScreen> createState() => _MerchandisingScreenState();
}

class _MerchandisingScreenState extends State<MerchandisingScreen> {
  final List<File> beforeImages = [];
  final List<File> afterImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        baseContext: context,
      ),
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.menu,
          //       color: Colors.white,
          //     )),
          title: Text(
            "EDS Survey",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 10),
                  child: SizedBox(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: beforeImages.length,
                      itemBuilder: (context, index) {
                        return MerchandisingListItem(
                          imageFile: beforeImages[index],
                          deleteCallback: () {
                            setState(() {
                              beforeImages.remove(beforeImages[index]);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                CustomButton(
                  onTap: () {
                    getImageFromCamera(true);
                  },
                  text: "Before Merchandising",
                  horizontalPadding: 80,
                  minWidth: 180,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 10),
                  child: SizedBox(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: afterImages.length,
                      itemBuilder: (context, index) {
                        return MerchandisingListItem(
                          imageFile: afterImages[index],
                          deleteCallback: () {
                            setState(() {
                              afterImages.remove(afterImages[index]);
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                CustomButton(
                  onTap: () => getImageFromCamera(false),
                  text: "After Merchandising",
                  horizontalPadding: 80,
                  minWidth: 180,
                  enabled: beforeImages.isNotEmpty,
                )
              ],
            ),
          ),
          CustomButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const GandolaScreen(),));
            },
            text: "Next",
            enabled: beforeImages.isNotEmpty && afterImages.isNotEmpty,
            fontSize: 22,
            horizontalPadding: 10,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<void> getImageFromCamera(bool beforeMerchandising) async {
    PermissionStatus cameraPermission = await Permission.camera.status;

    if (cameraPermission == PermissionStatus.denied) {
      cameraPermission = await Permission.camera.request();

      if (cameraPermission == PermissionStatus.permanentlyDenied) {
        return Future.error(
            "Camera permissions are permanently denied, we cannot request permissions.");
      }
    }

    final ImagePicker _picker = ImagePicker();

    XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File watermarkedImage = await addWatermark(pickedFile.path);
      setState(() {
        if (beforeMerchandising) {
          beforeImages.add(watermarkedImage);
        } else {
          afterImages.add(watermarkedImage);
        }
      });
    }
  }

  Future<File> addWatermark(String imagePath) async {
    // Get the current date and time
    DateTime now = DateTime.now();
    String formattedDateTime =
        "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now
        .second}";

    // Read the original image
    File file = File(imagePath);
    List<int> imageBytes = file.readAsBytesSync();
    img.Image? originalImage = img.decodeImage(Uint8List.fromList(imageBytes));

    // Add watermark text
    img.drawString(originalImage!, img.arial_48, 10, 10, formattedDateTime,
        color: img.getColor(255, 0, 0));

    // Create a new File for the watermarked image
    String outputImagePath = imagePath.replaceAll(
        '.jpg', '_watermarked.png'); // Customize the output file name if needed
    File watermarkedFile = File(outputImagePath);

    // Save the watermarked image
    watermarkedFile.writeAsBytesSync(img.encodePng(originalImage));

    // Return the File representing the watermarked image
    return watermarkedFile;
  }
}
