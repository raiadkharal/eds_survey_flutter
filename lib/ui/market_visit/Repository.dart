import 'dart:convert';
import 'dart:io';

import 'package:eds_survey/data/SurveySingletonModel.dart';
import 'package:eds_survey/data/WorkWithSingletonModel.dart';
import 'package:eds_survey/data/db/DatabaseHelper.dart';
import 'package:eds_survey/data/db/dao/MainDao.dart';
import 'package:eds_survey/data/db/dao/MainDaoImpl.dart';
import 'package:eds_survey/data/db/entities/designation.dart';
import 'package:eds_survey/data/db/entities/look_up_data.dart';
import 'package:eds_survey/data/db/entities/market_visit.dart';
import 'package:eds_survey/data/db/entities/outlet.dart';
import 'package:eds_survey/data/db/entities/task_type.dart';
import 'package:eds_survey/data/db/entities/workwith/Psr.dart';
import 'package:eds_survey/data/models/BaseResponse.dart';
import 'package:eds_survey/data/models/Configuration.dart';
import 'package:eds_survey/data/models/Product.dart';
import 'package:eds_survey/data/models/SurveyModel.dart';
import 'package:eds_survey/data/models/WorkStatus.dart';
import 'package:eds_survey/data_source/remote/ApiService.dart';
import 'package:eds_survey/data_source/remote/response/ApiResponse.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/Event.dart';
import 'package:eds_survey/utils/NetworkManager.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/db/entities/distribution.dart';
import '../../data/db/entities/merchandise.dart';
import '../../data/db/entities/route.dart';
import '../../data/db/entities/workwith/WDistribution.dart';
import '../../data/db/entities/workwith/WOutlet.dart';
import '../../data/db/entities/workwith/WRoute.dart';
import '../../data/db/entities/workwith/WTaskType.dart';
import '../../data/db/entities/workwith/WorkWithPost.dart';
import '../../data/db/entities/workwith/WorkWithPre.dart';
import '../../data/models/MerchandisingImage.dart';
import '../../utils/PreferenceUtil.dart';
import '../../utils/Util.dart';

class Repository extends GetxController {
  static Repository? _repository;
  final MainDao _mainDao;
  final ApiService _apiService;
  final PreferenceUtil _preferenceUtil;
  late RxBool _isLoading;
  late RxBool _postWorkWithSaved;
  late RxBool _surveySaved;
  late Rx<Event<bool>> _surveySavedWithEvent;
  late Rx<Event<String>> _msg;

  Repository._(this._mainDao, this._preferenceUtil, this._apiService) {
    _isLoading = false.obs;
    _postWorkWithSaved = false.obs;
    _surveySaved = false.obs;
    _surveySavedWithEvent = Event(false).obs;
    _msg = Event("").obs;
  }

  static Repository getInstance(
      MainDao mainDao, PreferenceUtil preferenceUtil, ApiService apiService) {
    _repository ??= Repository._(mainDao, preferenceUtil, apiService);
    return _repository!;
  }

  Future<List<Distribution>> getMarketVisitDistributions() async {
    return _mainDao.findMarketVisitDistributions();
  }

  Future<List<WDistribution>> getWorkWithDistributions() async {
    return _mainDao.findWorkWithDistributions();
  }

  Future<List<Designation>> getDesignations() async {
    return _mainDao.findAllDesignation();
  }

  Future<List<MRoute>> getRoutes(int distributionId) async {
    return _mainDao.findAllRoutes(distributionId);
  }

  Future<List<WRoute>> getWRoutes(int distributionId) async {
    return _mainDao.findWRoutes(distributionId);
  }

  Future<int> marketVisitOutletCount(int routeId) async {
    return _mainDao.marketVisitOutlets(routeId);
  }

  Future<List<Outlet>> getOutlets(int routeId, int distributionId) async {
    return _mainDao.findAllOutletsForRoute(routeId, distributionId);
  }

  Future<List<WOutlet>> getWOutlets(int routeId) async {
    return _mainDao.findWOutletsForRoute(routeId);
  }

  Future<Outlet> getOutlet(int selectedOutletId) async {
    return _mainDao.findOutletById(selectedOutletId);
  }

  Future<WOutlet> getWOutlet(int selectedOutletId) async {
    return _mainDao.findWOutletById(selectedOutletId);
  }

  void saveSurvey() {
    SurveySingletonModel instance = SurveySingletonModel.getInstance();
    SurveyModel dataModel = SurveyModel();

    dataModel.setStatusId(instance.getStatusId() ?? 0);
    dataModel
        .setStartDateTime(instance.getStartDateTime()?.millisecondsSinceEpoch);
    dataModel.setEndDateTime(DateTime.now().millisecondsSinceEpoch);
    dataModel.setAssets(instance.getAssets());
    dataModel.setOutletId(instance.getOutletId());
    dataModel.setOutletLatitude(instance.getOutletLatitude() ?? 0.0);
    dataModel.setOutletLongitude(instance.getOutletLongitude() ?? 0.0);
    dataModel.setDistance(instance.getDistance() ?? 0.0);
    dataModel.setTasks(instance.getTasks());
    dataModel.setMarketVisitResponses(instance.getMarketVisitResponses());
    dataModel.setMerchandisingImages([]);
    dataModel.setSurveyWith(instance.getSurveyWith());
    dataModel.setFeedBack(instance.getFeedBack() ?? "");
    dataModel.setRemarks(instance.getRemarks() ?? "");
    dataModel.setCustomerSignature(instance.getCustomerSignature() ?? "");
    dataModel.setLatitude(instance.getLatitude() ?? 0.0);
    dataModel.setLongitude(instance.getLongitude() ?? 0.0);

    dataModel.setOutletImages(instance.getOutletImages());

    uploadData(dataModel);
  }

  void postWorkWith(WorkWithSingletonModel workWithModel) async {
    setLoading(true);
    // set route id before posting if null or 0
    if (workWithModel.getRouteId() == null || workWithModel.getRouteId() == 0) {
      if (workWithModel.outletId != null) {
        WOutlet outlet = await getWOutlet(workWithModel.outletId!);
        workWithModel.setRouteId(outlet.routeId);
      }
    }

    int? psrId = workWithModel.getPsrId();
    int? routeId = workWithModel.getRouteId();
    int? outletId = workWithModel.getOutletId();

    final json = jsonEncode(workWithModel.toJson());
    debugPrint("Before: $json");

    WorkWithPre workWith = WorkWithPre(
        routeId: routeId ?? 0,
        psrId: psrId ?? 0,
        synced: false,
        data: json,
        outletId: outletId);
    savePreWorkWithInDb(workWith);

    try {
      //TODO- uncomment this when merchandise images converted success to UTF-8 format
      // set merchandise images in work with model
      Merchandise? merchandises =
          await findMerchandise(workWithModel.getOutletId() ?? 0);
      List<MerchandisingImage> merchandisingImages = [];

      if (merchandises.merchandiseImages != null) {
        for (MerchandisingImage merchandisingImage
            in merchandises.merchandiseImages!) {
          merchandisingImage.image =
              await Util.imageFileToBase64(merchandisingImage.path ?? "");
          merchandisingImages.add(merchandisingImage);
        }
      }
      workWithModel.setMerchandisingImages(merchandisingImages);
    } catch (e) {
      e.printInfo();
    }
    String finalJson = jsonEncode(workWith.toJson());
    debugPrint("After: $finalJson");

    NetworkManager.getInstance().isConnectedToInternet().then((aBoolean) async{
      if (aBoolean) {
        final accessToken = _preferenceUtil.getToken();

       final response = await _apiService.saveWorkWith(workWithModel, accessToken);

          if (response.status == RequestStatus.SUCCESS) {
            try {
              BaseResponse baseResponse =
                  BaseResponse.fromJson(jsonDecode(response.data));
              if (bool.parse(baseResponse.success ?? "true")) {
                onUploadPostWorkWith(
                    baseResponse, true, workWithModel.getOutletId());
              } else {
                setLoading(false);
                setError(baseResponse.errorMessage);
              }
            } catch (e) {
              setLoading(false);
              showToastMessage("Something went wrong.Please try again later");
            }
          } else {
            setLoading(false);
            setError(response.message);
          }
      } else {
        onUploadPostWorkWith(
            BaseResponse.success("true"), false, workWithModel.getOutletId());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      setError("Something went wrong.Please try again later");
    });
  }

  void uploadData(SurveyModel dataModel) async {
    setLoading(true);

    String jsonValue = jsonEncode(dataModel.toJson());
    debugPrint("Before: $jsonValue");

    if (dataModel.outletId != null) {
      MarketVisit marketVisit =
          MarketVisit(dataModel.outletId!, false, jsonEncode(dataModel));
      saveMarketVisitInDb(marketVisit);

      try {
        //TODO- uncomment this when merchandise images converted success to UTF-8 format
        // set merchandise images in work with model
        Merchandise? merchandises =
            await findMerchandise(dataModel.getOutletId() ?? 0);
        List<MerchandisingImage> merchandisingImages = [];

        if (merchandises.merchandiseImages != null) {
          for (MerchandisingImage merchandisingImage
              in merchandises.merchandiseImages!) {
            merchandisingImage.image =
                await Util.imageFileToBase64(merchandisingImage.path ?? "");
            merchandisingImages.add(merchandisingImage);
          }
        }
        dataModel.setMerchandisingImages(merchandisingImages);
      } catch (e) {
        e.printInfo();
      }

      String finalJson = jsonEncode(dataModel.toJson());
      debugPrint("Before: $finalJson");

      NetworkManager.getInstance()
          .isConnectedToInternet()
          .then((aBoolean) async {
        if (aBoolean) {
          final accessToken = _preferenceUtil.getToken();

          final response = await _apiService.saveSurvey(dataModel, accessToken);

          if (response.status == RequestStatus.SUCCESS) {
            SurveyModel surveyModel =
                SurveyModel.fromJson(json.decode(response.data));
            if (bool.parse(surveyModel.success ?? "true")) {
              onUpload(surveyModel, true, dataModel.getOutletId());
            } else {
              setLoading(false);
              setError(surveyModel.errorMessage);
            }
          } else {
            setLoading(false);
            setError(response.message);
          }
        } else {
          onUpload(BaseResponse("true"), false, dataModel.getOutletId());
        }
      }).onError((error, stackTrace) {
        setLoading(false);
        setError("Something went wrong.Please try again later");
      });
    }
  }

  Configuration getConfiguration() => _preferenceUtil.getConfig();

  bool isTestUser() => _preferenceUtil.isTestUser();

  void setOutletStatus(int code) => _preferenceUtil.setOutletStatus(code);

  RxBool isLoading() => _isLoading;

  RxBool postWorkWithSaved() => _postWorkWithSaved;

  RxBool surveySaved() => _surveySaved;

  void setPostWorkWithSaved(bool value) {
    _postWorkWithSaved.value = value;
    _postWorkWithSaved.refresh();
  }

  void setSurveySaved(bool value) {
    _surveySaved.value = value;
    _surveySaved.refresh();
  }

  void setSurveySavedWithEvent(bool value) {
    _surveySavedWithEvent.value = Event(value);
    _surveySavedWithEvent.refresh();
  }

  Rx<Event<bool>> getSurveySavedWithEvent() => _surveySavedWithEvent;

  Rx<Event<String>> getMessage() => _msg;

  void setLoading(bool value) {
    _isLoading.value = value;
    _isLoading.refresh();
  }

  Future<List<TaskType>> getMVTaskTypes() async {
    return await _mainDao.getAllMVTaskType();
  }

  Future<List<WTaskType>> getWWTaskTypes() async {
    return await _mainDao.getWWTaskTypes();
  }

  Future<int> workWithOutletCount(int routeId) async =>
      _mainDao.workWithOutletCount(routeId);

  void savePreWorkWithInDb(WorkWithPre workWith) async =>
      _mainDao.insertPreWorkWithData(workWith);

  Future<Merchandise> findMerchandise(int outletId) async =>
      _mainDao.findMerchandiseByOutletId(outletId);

  onUploadPostWorkWith(
      BaseResponse response, bool isSaveOnline, int? outletId) {
    if (!bool.parse(response.success ?? "true")) {
      setPostWorkWithSaved(false);
      setError(response.errorMessage);
      return;
    }

    if (isSaveOnline) {
      deleteAllImageFiles(outletId);
    }

    Future.delayed(const Duration(milliseconds: 1500))
        .then((value) => updatePostWorkWithStatus(outletId, isSaveOnline));
  }

  void deleteAllImageFiles(int? outletId) async {
    if (outletId != null) {
      Merchandise? merchandises = await findMerchandise(outletId);
      if (merchandises.merchandiseImages != null) {
        for (MerchandisingImage merchandisingImage
            in merchandises.merchandiseImages!) {
          File file = File(merchandisingImage.path!);
          file.delete();
        }
      }
    }
  }

  void setError(dynamic message) {
    _msg.value = Event(message.toString());
    _msg.refresh();
  }

  void setProgressMsg(dynamic message) {
    _msg.value = Event(message.toString());
    _msg.refresh();
  }

  updatePostWorkWithStatus(int? outletId, bool sync) {
    if (outletId != null) {
      getWorkWith(outletId).then((workWith) {
        workWith.synced = true;
        _mainDao.updateWorkWith(workWith);
        if (sync) {
          _mainDao.deleteAllMerchandiseByOutlet(outletId);
        }
      }).whenComplete(() {
        updateWOutletStatus(outletId, sync);
      }).onError((error, stackTrace) {
        setError("Something went wrong.Please try again later");
      });
    }
  }

  Future<WorkWithPost> getWorkWith(int outletId) {
    return _mainDao.findWorkWithByOutletId(outletId);
  }

  void updateWOutletStatus(int outletId, bool surveyTaken) {
    getWOutlet(outletId).then((outlet) {
      outlet.surveyTaken = surveyTaken;
      outlet.alreadyVisit = true;

      updateWStatus(outlet);
    }).onError((error, stackTrace) {
      setError("Error saving Survey!");
      setLoading(false);
      setPostWorkWithSaved(false);
    });
  }

  void updateWStatus(WOutlet outlet) {
    outlet.lastVisit = "Today";
    outlet.alreadyVisit = true;

    _mainDao.updateWOutlet(outlet).whenComplete(() {
      setProgressMsg(Constants.LOADED);
      setLoading(false);
      setPostWorkWithSaved(true);
    });
  }

  Future<void> insertIntoDB(Merchandise merchandise) =>
      _mainDao.insertMerchandise(merchandise);

  Future<List<Psr>> getPSrs() => _mainDao.getAllPSrs();

  void saveMarketVisitInDb(MarketVisit marketVisit) =>
      _mainDao.insertMarketVisitData(marketVisit);

  void onUpload(
      BaseResponse orderResponseModel, bool isSaveOnline, int? outletId) {
    if (!bool.parse(orderResponseModel.success ?? "true")) {
      setError(orderResponseModel.errorMessage);
      return;
    }

    if (isSaveOnline) {
      deleteAllImageFiles(outletId);
    }

    Future.delayed(const Duration(milliseconds: 1500))
        .then((value) => updateOutletStatus(outletId, isSaveOnline));
  }

  updateOutletStatus(int? outletId, bool sync) {
    if (outletId != null) {
      getOutlet(outletId).then((outlet) {
        outlet.synced = sync;
        outlet.lastVisit = "Today";
        outlet.surveyTaken = true;
        outlet.alreadyVisit = true;

        _mainDao.updateOutlet(outlet);

        if (sync) {
          _mainDao.deleteAllMerchandiseByOutlet(outletId);
        }
      }).whenComplete(() {
        updateMarketSurveyStatus(outletId, sync);
      }).onError((error, stackTrace) {
        setError("Error saving Survey!");
        setLoading(false);
        setSurveySaved(false);
        setSurveySavedWithEvent(false);
      });
    }
  }

  void updateMarketSurveyStatus(int? outletId, bool sync) {
    if (outletId != null) {
      getMarketVisit(outletId).then((marketVisit) {
        marketVisit.synced = sync;
        _mainDao.updateMarketSurvey(marketVisit);
      }).whenComplete(() {
        setProgressMsg("Uploaded Success");
        setLoading(false);
        setSurveySaved(true);
        setSurveySavedWithEvent(true);
      }).onError((error, stackTrace) {});
    }
  }

  Future<MarketVisit> getMarketVisit(int outletId) =>
      _mainDao.findMarketVisitById(outletId);

  Future<List<String>?> getAllSkus() async {
    return _mainDao.getAllSkus().then((productList) =>
        productList?.map((product) => product.productName ?? "").toList());
  }

  Future<LookUpData> getBrandsAndPackages() {
    return _mainDao.getBrandsAndPackages();
  }
}
