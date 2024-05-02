import 'package:eds_survey/data/MarketVisitResponse.dart';
import 'package:get/get.dart';

import '../../../data/SurveySingletonModel.dart';

class CustomerServiceViewModel extends GetxController{

  RxBool cs1DataSaved =false.obs;

  CustomerServiceViewModel(){
    cs1DataSaved=false.obs;
  }

  void csDataSet(List<MarketVisitResponse> marketVisitResponses){
    SurveySingletonModel.getInstance().addResponses(marketVisitResponses);
    setCs1DataSaved(true);
  }


  void setCs1DataSaved(bool value){
    cs1DataSaved.value=value;
    cs1DataSaved.refresh();
  }
}