import 'package:eds_survey/Route.dart';
import 'package:eds_survey/ui/SplashScreen.dart';
import 'package:eds_survey/ui/home/HomeScreen.dart';
import 'package:eds_survey/ui/login/LoginScreen.dart';
import 'package:eds_survey/ui/market_visit/competitor_stock_info/CompetitorStockInformationScreen.dart';
import 'package:eds_survey/ui/market_visit/coolers_verification/CoolerVerificationScreen.dart';
import 'package:eds_survey/ui/market_visit/customer_service/CustomerServiceScreen.dart';
import 'package:eds_survey/ui/market_visit/expired_stock/ExpiredStockScreen.dart';
import 'package:eds_survey/ui/market_visit/feedback/SurveyFeedbackScreen.dart';
import 'package:eds_survey/ui/market_visit/gandola/GandolaScreen.dart';
import 'package:eds_survey/ui/market_visit/load_outlets/LoadOutletsScreen.dart';
import 'package:eds_survey/ui/market_visit/stock_information/StockInformationScreen.dart';
import 'package:eds_survey/ui/market_visit/stock_information/StockInformationViewModel.dart';
import 'package:eds_survey/ui/new_outlet_request/NewOutletRequestScreen.dart';
import 'package:eds_survey/ui/new_outlet_request/form_one/FormOne.dart';
import 'package:eds_survey/ui/new_outlet_request/form_two/FormTwo.dart';
import 'package:eds_survey/ui/outlet/merchandising/MerchandisingScreen.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletsScreen.dart';
import 'package:eds_survey/ui/outlet/summary/OutletSummaryScreen.dart';
import 'package:eds_survey/ui/outlet_request/OutletRequestScreen.dart';
import 'package:eds_survey/ui/outlet_request/draft/DraftScreen.dart';
import 'package:eds_survey/ui/priorities/PrioritiesScreen.dart';
import 'package:eds_survey/ui/upload/UploadScreen.dart';
import 'package:eds_survey/ui/work_with/execution_standards/ExecutionStandardsScreen.dart';
import 'package:eds_survey/ui/work_with/main/WorkWithMainScreen.dart';
import 'package:eds_survey/ui/work_with/remarks/RemarksScreen.dart';
import 'package:eds_survey/ui/work_with/steps_of_call/StepsOfCallScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 1000));
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EDS Survey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(
            name: Routes.splash, page: () => const SplashScreen(),transition: Transition.fade),
        GetPage(
            name: Routes.login, page: () => const LoginScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.home, page: () => const HomeScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.loadOutlets, page: () => const LoadOutletsScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.workWithMain, page: () => const WorkWithMainScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.outletList, page: () => const OutletListScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.outletSummary, page: () => const OutletSummaryScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.merchandising, page: () => const MerchandisingScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.gandola, page: () => const GandolaScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.customerService, page: () => const CustomerServiceScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.coolerVerification, page: () => const CoolerVerificationScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.stockInformation, page: () => const StockInformationScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.competitorStockInformation, page: () => const CompetitorStockInformationScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.expiredStock, page: () => const ExpiredStockScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.surveyFeedback, page: () => const SurveyFeedbackScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.priorities, page: () => const PrioritiesScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.executionStandards, page: () => const ExecutionStandardsScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.stepsOfCall, page: () => const StepOfCallScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.remarks, page: () => const RemarksScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.upload, page: () => const UploadScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.outletRequest, page: () => const OutletRequestScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.newOutletRequest, page: () => const NewOutletRequestScreen(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.outletRequestFormOne, page: () => const FormOne(),transition: Transition.rightToLeft),
        GetPage(
            name: Routes.outletRequestFormTwo, page: () => const FormTwo(),transition:Transition.rightToLeft),


      ],
    );
  }
}
