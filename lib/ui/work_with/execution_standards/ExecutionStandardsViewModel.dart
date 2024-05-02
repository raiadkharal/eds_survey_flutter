
import 'package:eds_survey/data/MarketVisitResponse.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:get/get.dart';

import '../../../data/WorkWithSingletonModel.dart';

class ExecutionStandardsViewModel extends GetxController {
  List<MarketVisitResponse?> responseList = [];
  RxBool navigate = false.obs;


  List<String> questionList = [
  "Appropriate Cooler (At least one cooler in the outlet)",
  "Cooler Prime Location \n(Visible, HighTraffic, Superior To Competitor)",
  "Merchandising (% of cooler merchandised as per \nplanogram)",
  "Core SKU Range (All Core \nSKU\'S available)",
  "Price Communication (Pricing For All SKU\'S)",
  "Freshness (No Expiry, \nRotation, Damage)",
  "Customer Service (Customer Knows PSR Name, Visit Day)",
  ];

  void addResponse(int index, String? value) {

    if (value == null) {
      responseList.add(null);
      return;
    }
    switch (index) {
      case 0:
        responseList.add(MarketVisitResponse("ES","ES_AC",value));
        break;
      case 1:
        responseList.add(MarketVisitResponse("ES","ES_CPL",value));
        break;
      case 2:
        responseList.add(MarketVisitResponse("ES","ES_MERCHAND",value));
        break;
      case 3:
        responseList.add(MarketVisitResponse("ES","ES_CSR",value));
        break;
      case 4:
        responseList.add(MarketVisitResponse("ES","ES_PC",value));
        break;
      case 5:
        responseList.add(MarketVisitResponse("ES","ES_FRESHNESS",value));
        break;
      case 6:
        responseList.add(MarketVisitResponse("ES","ES_CS",value));
        break;
    }
  }

  void validate() {
    if (responseList.length < 7 || _containsNull(responseList)) {
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
