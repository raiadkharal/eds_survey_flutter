import 'package:eds_survey/data_source/remote/ApiService.dart';
import 'package:eds_survey/ui/login/LoginRepository.dart';
import 'package:eds_survey/ui/login/LoginViewModel.dart';
import 'package:eds_survey/ui/work_with/main/WorkWithMainViewModel.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/db/DatabaseHelper.dart';
import '../../data/db/dao/MainDao.dart';
import '../../data/db/dao/MainDaoImpl.dart';
import '../../ui/home/HomeRepository.dart';
import '../../ui/home/HomeViewModel.dart';
import '../../ui/market_visit/Repository.dart';
import '../../ui/market_visit/SurveyViewModel.dart';
import '../../ui/outlet/outlet_list/OutletsViewModel.dart';

class SurveyBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.put<ApiService>(ApiService(), permanent: true);
    await Get.putAsync<Database>(
        () async => await DatabaseHelper.initDatabase(),
        permanent: true);
    Get.put<MainDao>(MainDaoImpl(Get.find()), permanent: true);
    await Get.putAsync<SharedPreferences>(
        () async => await SharedPreferences.getInstance(),
        permanent: true);
    Get.put<PreferenceUtil>(PreferenceUtil.getInstanceSync(Get.find()),
        permanent: true);
    Get.put<HomeRepository>(
        HomeRepository.singleInstance(Get.find(), Get.find(), Get.find()),
        permanent: true);
    Get.put<HomeViewModel>(HomeViewModel(Get.find(), Get.find()),
        permanent: true);
    Get.put<Repository>(
        Repository.getInstance(Get.find(), Get.find(), Get.find()),
        permanent: true);
    Get.put<OutletsViewModel>(OutletsViewModel(Get.find()), permanent: true);
    Get.put<SurveyViewModel>(SurveyViewModel(Get.find(), Get.find()),
        permanent: true);
    // Get.put<OutletSummaryViewModel>(OutletSummaryViewModel(Get.find()),
    //     permanent: true);
    // Get.put<MerchandisingViewModel>(MerchandisingViewModel(Get.find()),
    //     permanent: true);
    Get.lazyPut<LoginRepository>(
        () => LoginRepository.getInstance(Get.find(), Get.find()));
    Get.lazyPut<LoginViewModel>(() => LoginViewModel(Get.find(), Get.find()));
    Get.put<WorkWithMainViewModel>(
        WorkWithMainViewModel(Get.find(), Get.find()),
        permanent: true);
    // Get.put<PrioritiesViewModel>(PrioritiesViewModel(Get.find()),
    //     permanent: true);
    // Get.put<GandolaViewModel>(GandolaViewModel(), permanent: true);
    // Get.put<CustomerServiceViewModel>(CustomerServiceViewModel(),
    //     permanent: true);
    // Get.put<StockInformationViewModel>(StockInformationViewModel(),
    //     permanent: true);
    // Get.put<SurveyFeedbackViewModel>(SurveyFeedbackViewModel(Get.find()),
    //     permanent: true);
    // Get.put<CoolerVerificationViewModel>(CoolerVerificationViewModel(),
    //     permanent: true);
  }
}
