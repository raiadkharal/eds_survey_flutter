
import 'package:json_annotation/json_annotation.dart';

import 'MarketVisitResponse.dart';
import 'db/entities/task.dart';
import 'models/MerchandisingImage.dart';

part 'WorkWithSingletonModel.g.dart';

@JsonSerializable()
class WorkWithSingletonModel {

  static WorkWithSingletonModel? _instance;

  static WorkWithSingletonModel getInstance() {
    _instance ??= WorkWithSingletonModel._internal();
    return _instance!;
  }

  WorkWithSingletonModel._internal();


  int? date;
  String? psrCode;
  int? routeId;
  String? userCode;
  int? outletId;
  int? distributionId;
  int? statusId;
  String? remarks, feedback;
  List<String>? barCodes;
  double? stcCount, esCount;
  int? MAStrenght1, MAStrenght2, ESStrenght1, ESStrenght2;
  String? MAOpportunity1, MAOpportunity2, ESOpportunity1, ESOpportunity2;
  List<MarketVisitResponse>? responses=[];
  List<Task>? tasks;
  int? dailyVisitId;
  String? objective;
  int? startDateTime, endDateTime;
  double? latitude, longitude;
  double? outletLatitude, outletLongitude;
  double? distance;
  int? status;
  int? psrId;
  List<String> questionsCode = [];
  String? customerSignature, surveyorName, surveyorDesignation;
  List<MerchandisingImage>? merchandisingImages;

  void setDailyVisitId(int dailyVisitId) {
    this.dailyVisitId = dailyVisitId;
  }

  WorkWithSingletonModel();

  void setMainScreenData(int routeId, int date, int distributionId) {
    this.routeId = routeId;
    this.date = date;
    this.distributionId = distributionId;
  }

  void setSection1Data(int MAStrenght1, int MAStrenght2, int ESStrenght1, int ESStrenght2,
      String MAOpportunity1, String MAOpportunity2, String ESOpportunity1, String ESOpportunity2) {
    this.MAStrenght1 = MAStrenght1;
    this.MAStrenght2 = MAStrenght2;
    this.ESStrenght1 = ESStrenght1;
    this.ESStrenght2 = ESStrenght2;
    this.MAOpportunity1 = MAOpportunity1;
    this.MAOpportunity2 = MAOpportunity2;
    this.ESOpportunity1 = ESOpportunity1;
    this.ESOpportunity2 = ESOpportunity2;
  }

  void setSection2Data(String objective) {
    this.objective = objective;
  }

  void setRemarksScreenData(String remarks, double stcCount, double esCount, List<String> barCodes) {
    this.remarks = remarks;
    this.stcCount = stcCount;
    this.esCount = esCount;
    this.barCodes = barCodes;
  }

  String? getPsrCode() {
    return psrCode;
  }

  int? getRouteId() {
    return routeId;
  }

  void setRouteId(int? routeId) {
    this.routeId = routeId;
  }

  String? getUserCode() {
    return userCode;
  }

  int? getOutletId() {
    return outletId;
  }

  void setOutletId(int outletId) {
    this.outletId = outletId;
  }

  double? getOutletLatitude() {
    return outletLatitude;
  }

  void setOutletLatitude(double? outletLatitude) {
    this.outletLatitude = outletLatitude;
  }

  double? getOutletLongitude() {
    return outletLongitude;
  }

  void setOutletLongitude(double? outletLongitude) {
    this.outletLongitude = outletLongitude;
  }

  double? getDistance() {
    return distance;
  }

  void setDistance(double distance) {
    this.distance = distance;
  }

  void setTasks(List<Task> tasks) {
    this.tasks = tasks;
  }

  List<Task>? getTasks() {
    tasks ??= [];
    return tasks;
  }

  List<MarketVisitResponse> getWorkWithResponses() {
    responses ??= [];
    return responses!;
  }

  void addResponse(MarketVisitResponse visitResponse) {
    bool contains = false;
    for (MarketVisitResponse mTask in getWorkWithResponses()) {
      if (mTask.questionCode == visitResponse.questionCode) {
        contains = true;
        break;
      }
    }
    if (!contains) getWorkWithResponses().add(visitResponse);
  }

  void addResponses(List<MarketVisitResponse?> visitResponse) {
    for (MarketVisitResponse? response in visitResponse) {
      if (response!.response.isNotEmpty && !questionsCode.contains(response.questionCode)) {
        getWorkWithResponses().add(response);
        questionsCode.add(response.questionCode);
      } else {
        if (getWorkWithResponses().isNotEmpty) {
          getWorkWithResponses()[questionsCode.indexOf(response.questionCode)] = response;
        }
      }
    }
  }

  void reset() {
    remarks=null;
    feedback=null;
    date=null;
    psrCode=null;
    merchandisingImages=[];
    customerSignature=null;
    distributionId=null;
    distance=null;
    routeId=null;
    outletId=null;
    date = 0;
    responses = [];
    tasks = [];
    esCount = stcCount = 0.0;
    questionsCode = [];
    objective = MAOpportunity1 = MAOpportunity2 = ESOpportunity1 = ESOpportunity2 = remarks = null;
    MAStrenght1 = MAStrenght2 = ESStrenght1 = ESStrenght2 = null;
    dailyVisitId = 0;
    barCodes = [];
  }

  void setStartTime(int time) {
    startDateTime = time;
  }

  void setLocation(double currentLatitude, double currentLongitude) {
    latitude = currentLatitude;
    longitude = currentLongitude;
  }

  String? getRemarks() {
    return remarks;
  }

  void setRemarks(String remarks) {
    this.remarks = remarks;
  }

  String? getCustomerSignature() {
    return customerSignature;
  }

  String? getFeedback() {
    return feedback;
  }

  void setFeedback(String feedback) {
    this.feedback = feedback;
  }

  void setCustomerSignature(String customerSignature) {
    this.customerSignature = customerSignature;
  }

  void setEndTime(int time) {
    endDateTime = time;
  }

  void setStatus(int status) {
    this.status = status;
  }

  int? getPsrId() {
    return psrId;
  }

  int? getStatusId() {
    return statusId;
  }

  void setStatusId(int statusId) {
    this.statusId = statusId;
  }

  List<MerchandisingImage>? getMerchandisingImages() {
    return merchandisingImages;
  }

  void setMerchandisingImages(List<MerchandisingImage> merchandisingImages) {
    this.merchandisingImages = merchandisingImages;
  }

  String? getSurveyorName() {
    return surveyorName;
  }

  void setSurveyorName(String surveyorName) {
    this.surveyorName = surveyorName;
  }

  String? getSurveyorDesignation() {
    return surveyorDesignation;
  }

  void setSurveyorDesignation(String surveyorDesignation) {
    this.surveyorDesignation = surveyorDesignation;
  }

  void setPsrCode(String psrCode) {
    this.psrCode = psrCode;
  }

  void setPsrId(int psrId) {
    this.psrId = psrId;
  }

  List<String> getQuestionsCode() {
    return questionsCode;
  }

  void setQuestionsCode(List<String> questionsCode) {
    this.questionsCode = questionsCode;
  }

  factory WorkWithSingletonModel.fromJson(Map<String, dynamic> json) => _$WorkWithSingletonModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkWithSingletonModelToJson(this);
}
