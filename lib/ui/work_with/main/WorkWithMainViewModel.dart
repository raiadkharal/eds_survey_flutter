import 'package:eds_survey/data/db/entities/workwith/WDistribution.dart';
import 'package:eds_survey/ui/home/HomeRepository.dart';
import 'package:eds_survey/ui/work_with/main/WorkWithMainScreen.dart';
import 'package:eds_survey/utils/Event.dart';
import 'package:get/get.dart';

import '../../../data/WorkWithSingletonModel.dart';
import '../../../data/db/entities/workwith/Psr.dart';
import '../../../data/db/entities/workwith/WRoute.dart';
import '../../market_visit/Repository.dart';

class WorkWithMainViewModel extends GetxController{

  final Repository _repository;
  final HomeRepository _homeRepository;
  late Future<List<WDistribution>> distributions;

  int? _selectedDistributionId;
  int? _selectedRouteId;

  late RxList<Psr> psrLiveData=RxList<Psr>([]);
  late Rx<bool> navigate;
  late Rx<String> msg;



  WorkWithMainViewModel(this._repository, this._homeRepository){
    navigate=false.obs;
    msg="".obs;
    loadData();
  }

  Future<void> loadData() async {
    distributions = _repository.getWorkWithDistributions();
    psrLiveData.value= await _repository.getPSrs();
  }


  Future<List<WRoute>> get routes async {
    if (getSelectedDistributionId() == 0) {
      //distributions already loaded get id of first distribution and find routes
      return distributions
          .then((value) => _repository.getWRoutes(value[0].distributionId));
    }
    return _repository.getWRoutes(getSelectedDistributionId());
  }

  int getSelectedRouteId() {
    return _selectedRouteId ?? 0;
  }

  void setSelectedRouteId(WRoute route) {
    _selectedRouteId = route.mRouteId;
  }


  int getSelectedDistributionId() {
    return _selectedDistributionId ?? 0;
  }

  void setSelectedDistribution(WDistribution selectedDistribution) {
    _selectedDistributionId = selectedDistribution.distributionId;
  }

  Future<int> workWithOutletCount(int routeId) {
    return _repository.workWithOutletCount(routeId);
  }

  RxBool isWorkWithOutletsLoaded() {
    return _homeRepository.isWorkWithOutletsLoaded();
  }

  Rx<Event<String>> getMessage() {
    return _homeRepository.getMessage();
  }

  Rx<bool> isLoading() {
    return _homeRepository.isLoading();
  }
  void getWorkWithOutlets(int routeId) {
    _homeRepository.workWithOutletByRouteId(routeId);
  }

  void validate() {
    if(_selectedRouteId==null||_selectedRouteId.toString().isEmpty||_selectedDistributionId==null){
     onError("Please Select all the fields");
      return;
    }

    WorkWithSingletonModel.getInstance().setMainScreenData(_selectedRouteId!,DateTime.now().millisecondsSinceEpoch,_selectedDistributionId!);
    setNavigation(true);
  }

  void onError(String message){
    msg.value=message;
    msg.refresh();
  }

  void setNavigation(bool value) {
    navigate.value=value;
    navigate.refresh();
  }
}