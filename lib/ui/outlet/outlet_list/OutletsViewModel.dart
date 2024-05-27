import 'package:eds_survey/data/db/entities/outlet.dart';
import 'package:eds_survey/data/models/Product.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/Enums.dart';

class OutletsViewModel extends GetxController {
  final Repository _repository;
  int? _selectedDistributionId;
  int? _selectedRouteId;
  SurveyType? _surveyType;
  final Rx<List<dynamic>> outlets=Rx<List<dynamic>>([]);

  OutletsViewModel(this._repository);


  @override
  void onReady() {
   _repository.getOutletStream().listen((outlets) {
     populateOutlets(outlets);
   },);

   _repository.getWOutletStream().listen((outlets) {
     populateOutlets(outlets);
   },);

    super.onReady();
  }

  int? getSelectedDistributionId() => _selectedDistributionId;

  void setSelectedDistributionId(int? distributionId) =>
      _selectedDistributionId = distributionId;

  int? getSelectedRouteId() => _selectedRouteId;

  void setSelectedRouteId(int? routeId) => _selectedRouteId = routeId;

  void setSurveyType(SurveyType surveyType) => _surveyType = surveyType;

  SurveyType? getSurveyType() => _surveyType;

  Future<void> loadOutlets() async {
    if (_selectedRouteId != null && _selectedDistributionId != null) {
      if (_surveyType == SurveyType.MARKET_VISIT) {
        final outlets = await _repository.getOutlets(
            _selectedRouteId!, _selectedDistributionId!);

        populateOutlets(outlets);

      } else {
        final outlets = await _repository.getWOutlets(_selectedRouteId!);
        populateOutlets(outlets);
      }
    }
  }

  void populateOutlets(List<dynamic> outletList){
    outlets.value=outletList;
    outlets.refresh();
  }
}
