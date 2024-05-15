import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../data/db/entities/outlet_request/RequestForm.dart';

class RevertedViewModel extends GetxController{
  final Repository _repository;
  RxList<RequestForm> revertedForms = RxList<RequestForm>();

  RevertedViewModel(this._repository){
    getRevertedForms(Constants.NEW_OUTLET_REQUEST_TYPE_ID,Constants.OUTLETS_REVERTED_WORKFLOW);
  }


  Future<void> getRevertedForms(int formId,int revertedId) async{
    revertedForms.value = await _repository.getRevertedForms(formId,revertedId);
    revertedForms.refresh();
  }
}