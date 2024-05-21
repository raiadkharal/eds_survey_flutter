import 'package:eds_survey/data/MarketVisitResponse.dart';
import 'package:eds_survey/data/models/Configuration.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:get/get.dart';

import '../../../data/SurveySingletonModel.dart';

class CustomerServiceViewModel extends GetxController{

  final Repository _repository;
  RxBool cs1DataSaved =false.obs;

  CustomerServiceViewModel(this._repository){
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

  Configuration getConfiguration() {
    return _repository.getConfiguration();
  }
}