import 'dart:typed_data';

import 'package:get/get.dart';

class FormTwoViewModel extends GetxController{
  Rx<Uint8List?> signatureImage = Rx<Uint8List>(Uint8List.fromList([]));

  void setSignatureImage(Uint8List? image){
    signatureImage.value=image;
  }


}