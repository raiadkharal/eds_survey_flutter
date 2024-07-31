import 'dart:async';

import 'package:eds_survey/data/db/entities/designation.dart';
import 'package:eds_survey/ui/home/HomeRepository.dart';
import 'package:eds_survey/utils/Event.dart';
import 'package:get/get.dart';

import '../../data/db/entities/distribution.dart';
import '../../data/db/entities/route.dart';
import 'Repository.dart';

class SurveyViewModel extends GetxController {
  final Repository _repository;
  final HomeRepository _homeRepository;
  late Future<List<Distribution>> distributions;
  late Future<List<Designation>> designations;

  // late Future<List<MRoute>> routes;

  int? _selectedDistributionId;
  int? _selectedRouteId;

  SurveyViewModel(this._repository, this._homeRepository);

  Future<void> loadData() async {
    distributions = _repository.getMarketVisitDistributions();
    designations = _repository.getDesignations();
  }

  Future<List<MRoute>> get routes async {
    if (getSelectedDistributionId() == 0) {
      //distributions already loaded get id of first distribution and find routes
      return distributions
          .then((value) => _repository.getRoutes(value[0].distributionId));
    }
    return _repository.getRoutes(getSelectedDistributionId());
  }

  int getSelectedDistributionId() => _selectedDistributionId ?? 0;

  void setSelectedDistribution(Distribution selectedDistribution) =>
      _selectedDistributionId = selectedDistribution.distributionId;

  int getSelectedRouteId() => _selectedRouteId ?? 0;

  void setSelectedRouteId(MRoute route) => _selectedRouteId = route.routeId;

  Future<int> marketVisitCount(int routeId) =>
      _repository.marketVisitOutletCount(routeId);

  void getMarketVisitOutlets(int routeId) =>
      _homeRepository.marketVisitOutletByRouteId(routeId);

  RxBool isMarketVisitOutletsLoaded() =>
      _homeRepository.isMarketVisitOutletsLoaded();

  Rx<Event<String>> getMessage() => _homeRepository.getMessage();

  RxBool isLoading() => _homeRepository.isLoading();
}
