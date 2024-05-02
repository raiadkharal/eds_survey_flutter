import 'package:eds_survey/data/db/entities/outlet.dart';
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

  OutletsViewModel(this._repository);

  int? getSelectedDistributionId() => _selectedDistributionId;

  void setSelectedDistributionId(int? distributionId) =>
      _selectedDistributionId = distributionId;

  int? getSelectedRouteId() => _selectedRouteId;

  void setSelectedRouteId(int? routeId) => _selectedRouteId = routeId;

  void setSurveyType(SurveyType surveyType) => _surveyType = surveyType;

  SurveyType? getSurveyType() => _surveyType;

  Future<List<dynamic>> loadOutlets() async {
    if (_selectedRouteId != null && _selectedDistributionId != null) {
      if (_surveyType == SurveyType.MARKET_VISIT) {
        return _repository.getOutlets(
            _selectedRouteId!, _selectedDistributionId!);
      } else {
        return _repository.getWOutlets(_selectedRouteId!);
      }
    }
    showToastMessage("Please Select route to load outlets");
    return [];
  }
}
