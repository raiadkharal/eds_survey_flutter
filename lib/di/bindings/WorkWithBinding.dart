

import 'package:eds_survey/ui/priorities/PrioritiesViewModel.dart';
import 'package:eds_survey/ui/work_with/execution_standards/ExecutionStandardsViewModel.dart';
import 'package:eds_survey/ui/work_with/steps_of_call/StepsOfCallViewModel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/db/DatabaseHelper.dart';
import '../../data/db/dao/MainDao.dart';
import '../../data/db/dao/MainDaoImpl.dart';
import '../../data_source/remote/ApiService.dart';
import '../../ui/home/HomeRepository.dart';
import '../../ui/home/HomeViewModel.dart';
import '../../ui/login/LoginRepository.dart';
import '../../ui/login/LoginViewModel.dart';
import '../../ui/market_visit/Repository.dart';
import '../../ui/market_visit/SurveyViewModel.dart';
import '../../ui/market_visit/feedback/SurveyFeedbackViewModel.dart';
import '../../ui/outlet/merchandising/MerchandingViewModel.dart';
import '../../ui/outlet/outlet_list/OutletsViewModel.dart';
import '../../ui/outlet/summary/OutletSummaryViewModel.dart';
import '../../ui/work_with/main/WorkWithMainViewModel.dart';
import '../../utils/PreferenceUtil.dart';

class WorkWithBinding implements Bindings{
  @override
  Future<void> dependencies() async {
    Get.put<ApiService>(ApiService(), permanent: true);
    await Get.putAsync<Database>(
            () async => await DatabaseHelper.getDatabase(),
        permanent: true);
    Get.put<MainDao>(MainDaoImpl(Get.find()), permanent: true);
    await Get.putAsync<SharedPreferences>(
            () async => await SharedPreferences.getInstance(),
        permanent: true);
    Get.put<PreferenceUtil>(PreferenceUtil.getInstanceSync(Get.find()),
        permanent: true);
    Get.put<Repository>(Repository.getInstance(Get.find(), Get.find(),Get.find()),
        permanent: true);
    Get.put<OutletsViewModel>(OutletsViewModel(Get.find()), permanent: true);
    Get.put<OutletSummaryViewModel>(OutletSummaryViewModel(Get.find()),
        permanent: true);
    Get.put<MerchandisingViewModel>(MerchandisingViewModel(Get.find()),
        permanent: true);

    Get.put<WorkWithMainViewModel>(WorkWithMainViewModel(Get.find(), Get.find()),permanent: true);
    Get.put<SurveyFeedbackViewModel>(SurveyFeedbackViewModel(Get.find()),permanent: true);
    Get.put<ExecutionStandardsViewModel>(ExecutionStandardsViewModel(),permanent: true);
    Get.put<StepsOfCallViewModel>(StepsOfCallViewModel(),permanent: true);
    Get.put<PrioritiesViewModel>(PrioritiesViewModel(Get.find()),permanent: true);

  }
}