
import 'dart:typed_data';

import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Event.dart';
import 'package:get/get.dart';
class SurveyFeedbackViewModel extends GetxController{
  Rx<Uint8List?> signatureImage = Rx<Uint8List>(Uint8List.fromList([]));
  final Repository _repository;

  SurveyFeedbackViewModel(this._repository);

  void setSignatureImage(Uint8List? image){
    signatureImage.value=image;
  }

  void saveSurvey() {
    _repository.saveSurvey();
  }
  RxBool isLoading()=>_repository.isLoading();

  RxBool isSurveySaved()=>_repository.surveySaved();

  Rx<Event<String>> getMessage()=>_repository.getMessage();


  // Future<String> readSignatureData() async {
  //   String fileName = "signature.txt";
  //   String signatureData = '';
  //
  //   try {
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     File file = File('${appDocDir.path}/$fileName');
  //
  //     if (await file.exists()) {
  //       List<String> lines = await file.readAsLines();
  //       signatureData = lines.join('\n');
  //     }
  //   } catch (e) {
  //     print('Error reading file: $e');
  //   }
  //
  //   return signatureData;
  // }
  //
  //
  // Future<void> saveImageData(Uint8List imageData) async {
  //   try {
  //     // Convert the Uint8List data to a UTF-8 encoded string
  //     String textData = utf8.decode(imageData);
  //
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     File file = File('${appDocDir.path}/signature.txt');
  //     await file.writeAsString(textData, mode: FileMode.writeOnly); // Write the string as UTF-8 text
  //     print('Image saved successfully');
  //     readSignatureData();
  //   } catch (e) {
  //     print('Error saving image: $e');
  //   }
  // }


}