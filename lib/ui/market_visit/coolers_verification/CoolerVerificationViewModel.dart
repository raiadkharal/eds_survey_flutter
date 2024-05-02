import 'package:eds_survey/data/MarketVisitResponse.dart';
import 'package:eds_survey/data/models/Configuration.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/ui/market_visit/coolers_verification/CoolerVerificationScreen.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:get/get.dart';

import '../../../data/SurveySingletonModel.dart';

class CoolerVerificationViewModel extends GetxController{

  final Repository _repository;

  void setData(List<MarketVisitResponse> marketVisitResponses) async{
    SurveySingletonModel.getInstance().addResponses(marketVisitResponses);
    // showToastMessage("Data saved");
    // cVefDataSaved.setValue(true);
  }

  CoolerVerificationViewModel(this._repository);

  Configuration getConfiguration() => _repository.getConfiguration();

}