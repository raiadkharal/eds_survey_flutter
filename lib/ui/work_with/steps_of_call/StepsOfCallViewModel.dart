import 'package:get/get.dart';

import '../../../data/MarketVisitResponse.dart';
import '../../../data/WorkWithSingletonModel.dart';
import '../../../utils/Utils.dart';

class StepsOfCallViewModel extends GetxController{
  List<MarketVisitResponse?> responseList = [];
  RxBool navigate = false.obs;

  List<String> questionsList = [
    "Prepare for Call",
    "Greet the Customer",
    "Stock check",
    "Merchandising",
    "Suggest the order",
    "Presentation",
    "Curbside DE-Brief",
    "Confirm Order",
  ];

  void addResponse(int index, String? value) {

    if (value == null) {
      responseList.add(null);
      return;
    }
    switch (index) {
      case 0:
        responseList.add(MarketVisitResponse("STC","STC_PFC",value));
        break;
      case 1:
        responseList.add(MarketVisitResponse("STC","STC_GTC",value));
        break;
      case 2:
        responseList.add(MarketVisitResponse("STC","STC_WTS",value));
        break;
      case 3:
        responseList.add(MarketVisitResponse("STC","STC_MERCHAND",value));
        break;
      case 4:
        responseList.add(MarketVisitResponse("STC","STC_DTO",value));
        break;
      case 5:
        responseList.add(MarketVisitResponse("STC","STC_PRESO",value));
        break;
      case 6:
        responseList.add(MarketVisitResponse("STC","STC_CRB_BRIEF",value));
        break;
      case 7:
        responseList.add(MarketVisitResponse("STC","STC_ADMIN",value));
        break;
    }
  }

  void validate() {
    if (responseList.length < 8 || _containsNull(responseList)) {
      showToastMessage("Please Complete Form Values");
    } else {
      WorkWithSingletonModel.getInstance().addResponses(responseList);
      navigate.value = true;
      navigate.refresh();
    }
  }

  bool _containsNull(List<MarketVisitResponse?> marketVisitResponses) {
    bool contain = false;
    for (MarketVisitResponse? response in marketVisitResponses) {
      if (response == null) {
        contain = true;
        break;
      }
    }
    return contain;
  }

}