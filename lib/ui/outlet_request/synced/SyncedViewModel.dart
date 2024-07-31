import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../data/db/entities/outlet_request/RequestForm.dart';

class SyncedViewModel extends GetxController{
  final Repository _repository;
  RxList<RequestForm> syncedForms = RxList<RequestForm>();

  SyncedViewModel(this._repository);


  Future<void> getRevertedForms(int revertedId,int formId) async{
    syncedForms.value = await _repository.getSyncedForms(revertedId,formId);
    syncedForms.refresh();
  }
}