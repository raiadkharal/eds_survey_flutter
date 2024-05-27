import 'package:eds_survey/data/SurveySingletonModel.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:get/get.dart';

import '../../../data/MarketVisitResponse.dart';
import '../../../data/models/CheckBoxModel.dart';

class CompetitorStockInformationViewModel extends GetxController {
  final Repository _repository;
  List<MarketVisitResponse> marketVisitResponseList = [];

  Rx<List<String>> selectedItems = RxList<String>().obs;

  CompetitorStockInformationViewModel(this._repository);

  Future<List<String>?> loadSkus() {
    return _repository.getAllSkus();
  }

  RxList<CheckBoxModel> skus = RxList<CheckBoxModel>();

  RxBool sIDataSaved = false.obs;

  void addMarketVisitResponse(String value, int index) {
    //remove response if already added same in the list
    removeResponse(MarketVisitResponse("CSI", "CSI_C${index + 1}", value))
        .whenComplete(
      () {
        marketVisitResponseList
            .add(MarketVisitResponse("CSI", "CSI_C${index + 1}", value));
      },
    );
  }

  void setData() async {
    //delete all the stock information responses if already have
    SurveySingletonModel.getInstance()
        .removeMarketVisitResponsesByCode("CSI_C1")
        .whenComplete(
      () {
        //add responses to survey model
        SurveySingletonModel.getInstance()
            .addResponses(marketVisitResponseList);
        setsIDataSaved(true);
      },
    );
  }

  void setsIDataSaved(bool value) {
    sIDataSaved.value = value;
    sIDataSaved.refresh();
  }

  void toggleItem(String item) {
    if (selectedItems.value.contains(item)) {
      selectedItems.value.remove(item);
    } else {
      selectedItems.value.add(item);
    }
    selectedItems.refresh();
  }

  bool validate() {
    bool isCheckList1Selected = false;
    bool isCheckList2Selected = false;

    for (MarketVisitResponse response in marketVisitResponseList) {
      if (response.questionCode == "CSI_C1") {
        isCheckList1Selected = true;
      } else if (response.questionCode == "CSI_C2") {
        isCheckList2Selected = true;
      }
    }

    return isCheckList1Selected || isCheckList2Selected;
  }

  void onResumed() {
    List<MarketVisitResponse> marketList =
        SurveySingletonModel.getInstance().getMarketVisitResponses();

    if (SurveySingletonModel.getInstance()
        .getQuestionsCode()
        .contains("CSI_C1")) {
      SurveySingletonModel.getInstance().getQuestionsCode().remove("CSI_C1");
      SurveySingletonModel.getInstance().getQuestionsCode().remove("CSI_C2");

      for (MarketVisitResponse marketVisitResponse in marketList) {
        if (marketVisitResponse.questionCode == "CSI_C1" ||
            marketVisitResponse.questionCode == "CSI_C2") {
          SurveySingletonModel.getInstance()
              .getMarketVisitResponses()
              .remove(marketVisitResponse);
        }
      }
    }
  }

  Future<void> removeResponse(MarketVisitResponse visitResponse) async {
    for (MarketVisitResponse response in marketVisitResponseList) {
      if (response.isEqual(visitResponse)) {
        marketVisitResponseList.remove(response);
      }
    }
  }
}
