import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import '../ui/market_visit/asset_verification/data/Asset.dart';
import '../ui/market_visit/asset_verification/data/Image.dart';
import '../ui/market_visit/availability_sku/data/Product.dart';
import 'MarketVisitResponse.dart';
import 'db/entities/pack_mapping.dart';
import 'db/entities/task.dart';

part 'SurveySingletonModel.g.dart';

@JsonSerializable()
class SurveySingletonModel {
  DateTime? _startDateTime;
  double? _latitude;
  double? _longitude;
  List<Asset> _assets = [];
  List<Task> _tasks = [];
  String? _surveyWith;
  int? _outletId;
  int? _statusId;
  double? _outletLatitude;
  double? _outletLongitude;
  double? _distance;
  List<Image> _outletImages = [];
  List<MarketVisitResponse> _marketVisitResponses = [];
  List<Product> _productList = [];
  List<String> _questionsCode = [];
  List<Product> _selectedPacks = [];
  String? _remarks;
  String? _feedBack;
  String? _customerSignature;

  static SurveySingletonModel? _instance;

  static SurveySingletonModel getInstance() {
    _instance ??= SurveySingletonModel._internal();
    return _instance!;
  }

  SurveySingletonModel._internal();

  SurveySingletonModel();

  void reset() {
    _startDateTime = null;
    _assets.clear();
    _tasks.clear();
    _outletImages.clear();
    _marketVisitResponses.clear();
    _productList.clear();
    _questionsCode.clear();
    _selectedPacks.clear();
  }

  void setStartDateTime(DateTime? value) {
    _startDateTime = value;
  }

  DateTime? getStartDateTime() {
    return _startDateTime;
  }

  void setLocation(LatLng? currentLatLong) {
    if(currentLatLong!=null){
      _latitude=currentLatLong.latitude;
      _longitude=currentLatLong.longitude;
    }
  }

  double? getLatitude(){
    return _latitude;
  }

  double? getLongitude(){
    return _longitude;
  }

  void addAsset(Asset asset) {
    List<Asset> assets = getAssets();
    bool contains = false;
    for (int i = 0; i < assets.length; i++) {
      if (assets[i].assetId == asset.assetId) {
        getAssets()[i] = asset;
        contains = true;
        break;
      }
    }
    if (!contains) {
      getAssets().add(asset);
    }
  }

  List<Asset> getAssets() {
    return _assets;
  }

  void addTask(Task task) {
    List<Task> tasks = getTasks();
    bool contains = false;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].taskId == task.taskId) {
        getTasks()[i] = task;
        contains = true;
        break;
      }
    }
    if (!contains) {
      getTasks().add(task);
    }
  }

  List<Task> getTasks() {
    return _tasks;
  }

  void setTasks(List<Task> tasks) {
    _tasks = tasks;
  }

  void setSurveyWith(String value) {
    _surveyWith = value;
  }

  String? getSurveyWith() {
    return _surveyWith;
  }

  void setOutletId(int? value) {
    _outletId = value;
  }

  int? getOutletId() {
    return _outletId;
  }

  void setStatusId(int value) {
    _statusId = value;
  }

  int? getStatusId() {
    return _statusId;
  }

  void setOutletLatitude(double? value) {
    _outletLatitude = value;
  }

  double? getOutletLatitude() {
    return _outletLatitude;
  }

  void setOutletLongitude(double? value) {
    _outletLongitude = value;
  }

  double? getOutletLongitude() {
    return _outletLongitude;
  }

  void setDistance(double value) {
    _distance = value;
  }

  double? getDistance() {
    return _distance;
  }

  void setOutletImages(List<Image> value) {
    _outletImages = value;
  }

  List<Image> getOutletImages() {
    return _outletImages;
  }

  void addResponse(MarketVisitResponse visitResponse) {
    bool contains = false;
    for (MarketVisitResponse mTask in getMarketVisitResponses()) {
      if (mTask.questionCode.toLowerCase() ==
          visitResponse.questionCode.toLowerCase()) {
        contains = true;
        break;
      }
    }
    if (!contains) {
      getMarketVisitResponses().add(visitResponse);
    }
  }

  void addResponses(List<MarketVisitResponse> visitResponse) {
    for (MarketVisitResponse response in visitResponse) {
      if (response.getResponse().isNotEmpty &&
          (!_questionsCode.contains(response.questionCode) ||
              response.questionCode == "SI_C1" ||
              response.questionCode == "CSI_C1" ||
              response.questionCode == "CSI_C2")) {
        _marketVisitResponses.add(response);
        _questionsCode.add(response.questionCode);
      } else {
        if (getMarketVisitResponses().isNotEmpty) {
          _marketVisitResponses[_questionsCode.indexOf(response.questionCode)] =
              response;
        }
      }
    }
  }

  void updateSelectedItems(
      PackMapping packMapping, String value, bool isChecked) {
    String selectedItem =
        "${packMapping.packName}_${packMapping.companyName}_${packMapping.skuName}_$value";

    if (!isChecked) {
      _selectedPacks.remove(Product(selectedItem, false));
    } else {
      if (!_selectedPacks.contains(Product(selectedItem, true))) {
        _selectedPacks.add(Product(selectedItem, true));
      }
    }
  }

  void setAvailabilityBySkus(List<Product> selectedPacks) {

    for (Product product in selectedPacks) {
      addResponse(MarketVisitResponse("AS", product.skuFull, product.value.toString()));
    }
  }


  List<MarketVisitResponse> getMarketVisitResponses() {
    return _marketVisitResponses;
  }

  void setProductList(List<Product> value) {
    _productList = value;
  }

  List<Product> getSkuList() {
    return _productList;
  }

  void setQuestionsCode(List<String> value) {
    _questionsCode = value;
  }

  List<String> getQuestionsCode() {
    return _questionsCode;
  }

  void setSelectedPacks(List<Product> value) {
    _selectedPacks = value;
  }

  List<Product> getSelectedPacks() {
    return _selectedPacks;
  }

  void setRemarks(String value) {
    _remarks = value;
  }

  String? getRemarks() {
    return _remarks;
  }

  void setFeedBack(String value) {
    _feedBack = value;
  }

  String? getFeedBack() {
    return _feedBack;
  }

  void setCustomerSignature(String value) {
    _customerSignature = value;
  }

  String? getCustomerSignature() {
    return _customerSignature;
  }

  factory SurveySingletonModel.fromJson(Map<String, dynamic> json) => _$SurveySingletonModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurveySingletonModelToJson(this);
}
