import 'package:eds_survey/data/SurveySingletonModel.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:get/get.dart';

import '../../../data/MarketVisitResponse.dart';
import '../../../data/models/CheckBoxModel.dart';

class StockInformationViewModel extends GetxController {
  final Repository _repository;
  List<MarketVisitResponse> marketVisitResponseList = [];

  Rx<List<String>> selectedItems = RxList<String>().obs;

  StockInformationViewModel(this._repository);

  Future<List<String>?> loadSkus() {
    return _repository.getAllSkus();
  }

  RxList<CheckBoxModel> skus = RxList<CheckBoxModel>();

  RxBool sIDataSaved = false.obs;

  void addMarketVisitResponse(String value, int index) {
    //remove response if already added same in the list
    removeResponse(MarketVisitResponse("SI", "SI_C${index + 1}", value))
        .whenComplete(
      () {
        marketVisitResponseList
            .add(MarketVisitResponse("SI", "SI_C${index + 1}", value));
      },
    );

    // switch (index) {
    //   case 0:
    //
    //
    //     break;
    //   case 1:
    //   //remove response if already added same in the list
    //     removeResponse(MarketVisitResponse("SI", "SI_C${index + 1}", value));
    //     marketVisitResponseList
    //         .add(MarketVisitResponse("SI", "SI_C${index + 1}", value));
    //     break;
    //   case 2:
    //   //remove response if already added same in the list
    //     removeResponse(MarketVisitResponse("SI", "SI_C${index + 1}", value));
    //     marketVisitResponseList
    //         .add(MarketVisitResponse("SI", "SI_C${index + 1}", value));
    //     break;
    // }
  }

  void setData() async {
    //delete all the stock information responses if already have
    SurveySingletonModel.getInstance()
        .removeMarketVisitResponsesByCode("SI_C1")
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
    // bool isCheckList2Selected = false;
    // bool isCheckList3Selected = false;

    for (MarketVisitResponse response in marketVisitResponseList) {
      if (response.questionCode == "SI_C1") {
        isCheckList1Selected = true;
      } else if (response.questionCode == "SI_C2") {
        // isCheckList2Selected = true;
      } else if (response.questionCode == "SI_C3") {
        // isCheckList3Selected = true;
      }
    }

    return isCheckList1Selected /*&& isCheckList2Selected && isCheckList3Selected*/;
  }

  void onResumed() {
    List<MarketVisitResponse> marketList =
        SurveySingletonModel.getInstance().getMarketVisitResponses();

    if (SurveySingletonModel.getInstance()
        .getQuestionsCode()
        .contains("SI_C1")) {
      SurveySingletonModel.getInstance().getQuestionsCode().remove("SI_C1");
      SurveySingletonModel.getInstance().getQuestionsCode().remove("SI_C2");
      SurveySingletonModel.getInstance().getQuestionsCode().remove("SI_C3");

      for (MarketVisitResponse marketVisitResponse in marketList) {
        if (marketVisitResponse.questionCode == "SI_C1" ||
            marketVisitResponse.questionCode == "SI_C2" ||
            marketVisitResponse.questionCode == "SI_C3") {
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
