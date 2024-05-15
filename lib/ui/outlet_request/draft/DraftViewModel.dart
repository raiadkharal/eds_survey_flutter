import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../data/db/entities/outlet_request/RequestForm.dart';

class DraftViewModel extends GetxController{
  final Repository _repository;
  RxList<RequestForm> draftForms = RxList<RequestForm>();

  DraftViewModel(this._repository){
    getDraftForm(Constants.NEW_OUTLET_REQUEST_TYPE_ID);
  }


  Future<void> getDraftForm(int formId) async{
  draftForms.value = await _repository.getDraftForms(formId);
  draftForms.refresh();
  }


  RxBool isOutletRequestSaved()=>_repository.isOutletRequestSaved();

}