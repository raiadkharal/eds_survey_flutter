import 'package:get/get.dart';

import '../../../data/MarketVisitResponse.dart';

class GandolaViewModel extends GetxController {
  Rx<String> selectedValue = Rx<String>("");
  Rx<String> selectedIntegrity = Rx<String>("");

  MarketVisitResponse? questionOneResponse , questionTwoResponse;

  RxBool isGandola=false.obs;


  GandolaViewModel();

  void setGandolaSelectedValue(String value) {
    selectedValue.value = value;
    selectedValue.refresh();
  }

  void setSelectedIntegrity(String value) {
    selectedIntegrity.value = value;
    selectedIntegrity.refresh();
  }


  void setQuestionOneResponse(String response)=>
    questionOneResponse = MarketVisitResponse("G" , "G_G" ,response);

  void setQuestionTwoResponse(String response)=>
    questionTwoResponse = MarketVisitResponse("G" , "G_GI" ,response);


  void setGandola(bool value){
    isGandola.value=value;
    isGandola.refresh();
  }

}

enum Gandola { Yes, No }
