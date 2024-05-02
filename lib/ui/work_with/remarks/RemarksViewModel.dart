import 'package:get/get.dart';

import '../../../data/MarketVisitResponse.dart';
import '../../../data/WorkWithSingletonModel.dart';

class RemarksViewModel extends GetxController{

   static const double TOTAL_STC = 8.0;
   static const double TOTAL_ES = 7.0;

  late Rx<String> stc="0.0/8.0".obs;
  late Rx<String> es="0.0/7.0".obs;
  RxBool navigate=false.obs;

  RemarksViewModel();

  void getTotal() {
    double totalStc=0.0;
    double totalEs=0.0;
    List<MarketVisitResponse> responses = WorkWithSingletonModel.getInstance().getWorkWithResponses();
    for(MarketVisitResponse response in responses){
      if(response.getType().toLowerCase()=="stc"){
        if(response.getResponse().toLowerCase()=="yes"){
          totalStc+=1;
        }
      }
      if(response.getType().toLowerCase()=="es"){
        if(response.getResponse().toLowerCase()=="yes"){
          totalEs+=1;
        }
      }
    }
    stc.value="$totalStc/$TOTAL_STC";
    stc.refresh();
    es.value="$totalEs/$TOTAL_ES";
    stc.refresh();
    es.refresh();
  }

  void validate(){
    navigate.value=true;
    navigate.refresh();
  }

}