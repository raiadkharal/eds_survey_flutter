import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/button/CustomButton.dart';
import 'package:eds_survey/data/SurveySingletonModel.dart';
import 'package:eds_survey/ui/market_visit/customer_service/CustomerServiceScreen.dart';
import 'package:eds_survey/ui/market_visit/gandola/GandolaScreen.dart';
import 'package:eds_survey/ui/outlet/merchandising/MerchandingViewModel.dart';
import 'package:eds_survey/ui/outlet/merchandising/MerchandisingListItem.dart';
import 'package:eds_survey/ui/work_with/execution_standards/ExecutionStandardsScreen.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../components/progress_dialog/PregressDialog.dart';
import '../../../data/models/MerchandisingImage.dart';
import '../../../utils/Colors.dart';

import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dart:math' as math;

class MerchandisingScreen extends StatefulWidget {
  const MerchandisingScreen({super.key});

  @override
  State<MerchandisingScreen> createState() => _MerchandisingScreenState();
}

class _MerchandisingScreenState extends State<MerchandisingScreen> {
  final MerchandisingViewModel controller =
      Get.put(MerchandisingViewModel(Get.find()));

  late final int outletId;
  late final SurveyType surveyType;

  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];
    setObservers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        baseContext: context,
      ),
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "EDS Survey",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 10),
                        child: SizedBox(
                          height: 150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.beforeImages.value.length,
                            itemBuilder: (context, index) {
                              return MerchandisingListItem(
                                merchandiseImage:
                                    controller.beforeImages.value[index],
                                deleteCallback: () {
                                  controller.removeMerchandiseImage(
                                      controller.beforeImages.value[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      onTap: () => getImageFromCamera(true),
                      text: "Before Merchandising",
                      horizontalPadding: 80,
                      minWidth: 180,
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 10),
                        child: SizedBox(
                          height: 150,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.afterImages.value.length,
                            itemBuilder: (context, index) {
                              return MerchandisingListItem(
                                merchandiseImage:
                                    controller.afterImages.value[index],
                                deleteCallback: () {
                                  controller.removeMerchandiseImage(
                                      controller.afterImages.value[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Obx(() => CustomButton(
                          onTap: () => getImageFromCamera(false),
                          text: "After Merchandising",
                          horizontalPadding: 80,
                          minWidth: 180,
                          enabled: controller.beforeImages.value.isNotEmpty,
                        )),
                  ],
                ),
              ),
              Obx(
                () => CustomButton(
                  onTap: () => onNextClick(),
                  text: "Next",
                  enabled: controller.beforeImages.value.isNotEmpty &&
                      controller.afterImages.value.isNotEmpty,
                  fontSize: 22,
                  horizontalPadding: 10,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Obx(
            () => controller.isLoading.value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void setObservers() {
    ever(controller.loadMerchandise(outletId), (merchandise) {
      updateMerchandiseList(merchandise.merchandiseImages);
    });

    ever(
      controller.imagesLiveData,
      (merchandiseImages) => updateMerchandiseList(merchandiseImages),
    );

    ever(controller.isSaved, (aBoolean) async {
      if (aBoolean) {
        // showToastMessage("Saved");
        if (surveyType == SurveyType.MARKET_VISIT) {
          if (controller.getConfiguration().tenantId ==
              Constants.ENGRO_USER_ID) {
           final result = await Get.toNamed(Routes.customerService,
                arguments: [outletId, surveyType]);

            if(result=="ok"){
             Get.back(result: result);
           }

          } else {
            final result = await Get.toNamed(Routes.gandola, arguments: [outletId, surveyType]);

            if(result=="ok"){
              Get.back(result: result);
            }

          }
        } else {
         final result = await Get.toNamed(Routes.executionStandards,
              arguments: [outletId, surveyType]);

          if(result=="ok"){
            Get.back(result: result);
          }

        }
      }
    });
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
    try {
      final ImagePicker picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setLoading(true);

        File? watermarkedImage = await addWatermark(pickedFile.path);
        setLoading(false);
        if (beforeMerchandising) {
          controller.saveImages(
              watermarkedImage?.path, Constants.MERCHANDISE_BEFORE_IMAGE);
        } else {
          controller.saveImages(
              watermarkedImage?.path, Constants.MERCHANDISE_AFTER_IMAGE);
        }
      } else {
        setLoading(false);
        showToastMessage("No Image Captured!");
      }
    } catch (e) {
      setLoading(false);
      showToastMessage("Something went wrong.Please try again!");
    }
  }



  // Future<File?> addWatermark(String imagePath) async {
  //   try {
  //     // Get the current date and time
  //     DateTime now = DateTime.now();
  //     String formattedDateTime =
  //         "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute}:${now.second}";
  //
  //     // Read the original image
  //     File file = File(imagePath);
  //     List<int> imageBytes = file.readAsBytesSync();
  //     img.Image? originalImage =
  //         img.decodeImage(Uint8List.fromList(imageBytes));
  //
  //     // Scale the image to adjust the font size
  //     double scaleFactor = calculateScaleFactor(
  //         originalImage); // Adjust the scale factor as needed
  //     img.Image resizedImage = img.copyResize(originalImage!,
  //         width: (originalImage.width * scaleFactor).round());
  //
  //     // Add watermark text
  //     img.drawString(resizedImage, img.arial_48, 20, 20, formattedDateTime,
  //         color: img.getColor(255, 0, 0));
  //
  //     // Create a new File for the watermarked image
  //     String outputImagePath = imagePath.replaceAll('.jpg',
  //         '_watermarked.png'); // Customize the output file name if needed
  //     File watermarkedFile = File(outputImagePath);
  //
  //     // Save the watermarked image
  //     watermarkedFile.writeAsBytesSync(img.encodePng(resizedImage));
  //     // Return the File representing the watermarked image
  //     return watermarkedFile;
  //   } catch (e) {
  //     showToastMessage(e.toString());
  //   }
  //   return null;
  // }

  Future<File?> addWatermark(String imagePath) async {
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(
      processImageInIsolate,
      [receivePort.sendPort, imagePath],
    );
    return await receivePort.first as File?;
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

  void onNextClick() {
    if (!controller.validateImageCount()) {
      return;
    }
    controller.insertMerchandiseIntoDB(outletId);
  }


 static Future<void> processImageInIsolate(List<dynamic> args) async {
    SendPort sendPort = args[0];
    String imagePath = args[1];

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
      Isolate.exit(sendPort,watermarkedFile);
    } catch (e) {
      // sendPort.send({'error': e.toString()});
      Isolate.exit();
    }
  }

  void updateMerchandiseList(List<MerchandisingImage>? merchandiseImages) {
    List<MerchandisingImage> merchandiseImagesBefore = [];
    List<MerchandisingImage> merchandiseImagesAfter = [];
    if (merchandiseImages != null) {
      for (MerchandisingImage image in merchandiseImages) {
        if (image.type == Constants.MERCHANDISE_BEFORE_IMAGE) {
          merchandiseImagesBefore.add(image);
        } else {
          merchandiseImagesAfter.add(image);
        }
      }
    }

    controller.populateMerchandise(true, merchandiseImagesBefore);
    controller.populateMerchandise(false, merchandiseImagesAfter);
  }

  void setLoading(bool value) {
    controller.setLoading(value);
  }
}
