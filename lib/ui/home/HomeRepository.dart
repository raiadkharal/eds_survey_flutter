import 'dart:convert';
import 'dart:io';

import 'package:eds_survey/data/SurveySingletonModel.dart';
import 'package:eds_survey/data/db/DatabaseHelper.dart';
import 'package:eds_survey/data/db/dao/MainDao.dart';
import 'package:eds_survey/data/db/dao/MainDaoImpl.dart';
import 'package:eds_survey/data/db/entities/market_visit.dart';
import 'package:eds_survey/data/db/entities/merchandise.dart';
import 'package:eds_survey/data/db/entities/outlet.dart';
import 'package:eds_survey/data/db/entities/outlet_request/OutletTable.dart';
import 'package:eds_survey/data/db/entities/workwith/WOutlet.dart';
import 'package:eds_survey/data/models/BaseResponse.dart';
import 'package:eds_survey/data/models/DocumentTable.dart';
import 'package:eds_survey/data/models/LogModel.dart';
import 'package:eds_survey/data/models/MainModel.dart';
import 'package:eds_survey/data/models/RoutesModel.dart';
import 'package:eds_survey/data/models/SurveyModel.dart';
import 'package:eds_survey/data/models/WorkStatus.dart';
import 'package:eds_survey/data/models/WorkWithResponseModel.dart';
import 'package:eds_survey/data_source/remote/ApiService.dart';
import 'package:eds_survey/data_source/remote/response/ApiResponse.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/NetworkManager.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data/WorkWithSingletonModel.dart';
import '../../data/db/entities/look_up_data.dart';
import '../../data/db/entities/workwith/WorkWithPost.dart';
import '../../data/db/entities/workwith/WorkWithPre.dart';
import '../../data/models/MerchandisingImage.dart';
import '../../data/models/TokenResponse.dart';
import '../../utils/Event.dart';
import '../../utils/Util.dart';

class HomeRepository extends GetxController {
  static HomeRepository? _instance;
  final ApiService _apiService;
  final PreferenceUtil _preferenceUtil;
  final MainDao _homeDao;
  final RxBool _isLoading = false.obs;
  late RxBool _isLoggedOut;
  late RxBool _onDayStart;
  late RxBool _isMarketVisitsOutletsLoaded;
  late RxBool _isWorkWithOutletsLoaded;
  final Rx<Event<String>> _msg = Event("").obs;
  final Rx<Event<String>> _progressMsg = Event("").obs;
  late RxBool _uploadCompleted;
  late Rx<RoutesModel> _routesModelMutableLiveData;

  int _remainingTasks = 0, _totalTasks = 0;

  static HomeRepository singleInstance(
      ApiService apiService, PreferenceUtil preferenceUtil, MainDao homeDao) {
    _instance ??= HomeRepository(apiService, preferenceUtil, homeDao);
    return _instance!;
  }

  HomeRepository(this._apiService, this._preferenceUtil, this._homeDao) {
    _onDayStart = _preferenceUtil.getWorkSyncData().isDayStarted.obs;
    _isLoggedOut = false.obs;
    _uploadCompleted = false.obs;
    _isMarketVisitsOutletsLoaded = false.obs;
    _isWorkWithOutletsLoaded = false.obs;
    _routesModelMutableLiveData = Rx<RoutesModel>(RoutesModel());
  }

  void getToken() async {
    setLoading(true);
    String username = _preferenceUtil.getUsername();
    String password = _preferenceUtil.getPassword();

    NetworkManager.getInstance().isConnectedToInternet().then((isOnline) {
      if (isOnline) {
        _apiService
            .getAccessToken("password", username, password)
            .then((response) {
          if (response.status == RequestStatus.SUCCESS) {
            // setLoading(false);

            //parse response json to dart model
            TokenResponse tokenResponse =
                TokenResponse.fromJson(jsonDecode(response.data));

            //save access token to local cache
            if (tokenResponse.accessToken != null) {
              _preferenceUtil.saveToken(tokenResponse.accessToken);
            }

            updateWorkStatus(true);
          } else {
            setLoading(false);
            onError(response.message.toString());
          }
        }).onError((error, stackTrace) {
          setLoading(false);
          if (error is HttpException || error is SocketException) {
            onError(Constants.NETWORK_ERROR);
          } else {
            onError(error.toString());
          }
        });
      } else {
        setLoading(false);
        onError("No Internet Connection");
      }
    });
  }

  void updateWorkStatus(bool isStart) async {
    //check if device is not connected to internet and return
    final isOnline = await NetworkManager.getInstance().isConnectedToInternet();
    if (!isOnline) {
      onError("No Internet Connection");
      return;
    }

    // setLoading(true);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    Map<String, dynamic> map = {};
    map['operationTypeId'] = isStart ? "1" : "2";
    map['statusForApp'] = "2";
    map['appVersion'] = packageInfo.buildNumber;

    String accessToken = _preferenceUtil.getToken();
    _apiService.updateStartEndStatus(map, accessToken).then((response) {
      setLoading(false);

      if (response.status == RequestStatus.SUCCESS) {
        //Parse data to LogModel
        LogModel logModel = LogModel.fromJson(jsonDecode(response.data));

        if (bool.parse(logModel.success ?? "true")) {
          WorkStatus status = _preferenceUtil.getWorkSyncData();
          status.dayStarted = 1;
          status.syncDate = logModel.startDay!;
          _preferenceUtil.saveWorkSyncData(status);
          _onDayStart.value = isStart;
          if (isStart) {
            fetchData(isStart);
          }
        } else {
          onError((logModel.errorCode == 1 || logModel.errorCode == 2)
              ? logModel.errorMessage ?? ""
              : Constants.GENERIC_ERROR);
        }
      } else {
        onError(response.message);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      onError(error.toString());
    });
  }

  void onError(dynamic message) {
    // _msg.value = Event(message.toString());
    // _msg.refresh();
    showToastMessage(message);
  }

  void setMessage(dynamic message) {
    showToastMessage(message);
  }

  void setProgressMsg(dynamic message) {
    _progressMsg.value = Event(message.toString());
    _progressMsg.refresh();
  }

  void setStartDay(bool value) {
    _onDayStart.value = value;
    _onDayStart.refresh();
  }

  void fetchData(bool onDayStart) async {
    NetworkManager.getInstance().isConnectedToInternet().then((isOnline) async {
      if (isOnline) {
        try {
          setLoading(true);
          String accessToken = _preferenceUtil.getToken();
          final response = await _apiService.loadData(accessToken);

          if (response.status == RequestStatus.SUCCESS) {
            var mainModel = MainModel.fromJson(jsonDecode(response.data));

            if (bool.parse(mainModel.success ?? "true")) {
              onDataLoaded(mainModel, onDayStart);
            } else {
              setLoading(false);
              onError(mainModel.errorMessage.toString());
            }
          } else {
            setLoading(false);
            onError(response.message);
          }
        } catch (e) {
          setLoading(false);
          onError(e.toString());
        }
      } else {
        setLoading(false);
        onError("No Internet Connection");
      }
    });
  }

  void onDataLoaded(MainModel response, bool loadedOnDayStart) async {
    try {
      clearDb(_homeDao).then((value) {
        if (loadedOnDayStart) {
          _homeDao.deleteAllMarketSurveys();
          _homeDao.deleteAllPreWorkWith();
          _homeDao.deleteAllPostWorkWith();
          _homeDao.deleteAllMerchandise();
          _homeDao.deletePackagesAndBrands();
        }
      }).then((value) {
        if (response.routes != null) _homeDao.insertRoutes(response.routes!);
      }).then((value) {
        if (response.designations != null) {
          _homeDao.insertDesignations(response.designations!);
        }
      }).then((value) {
        if (response.distributions != null) {
          _homeDao.insertDistribution(response.distributions!);
        }
      }).then((value) {
        if (response.taskTypes != null) {
          _homeDao.insertTaskTypes(response.taskTypes!);
        }
      }).then((value) {
        if (response.tasks != null) _homeDao.insertTasks(response.tasks!);
      }).then((value) {
        if (response.packMappings != null) {
          _homeDao.insertPackages(response.packMappings!);
        }
      }).then((value) {
        if (response.missingReasons != null) {
          _homeDao.insertAssetMissingReason(response.missingReasons!);
        }
      }).then((value) {
        if (response.outletAssets != null) {
          _homeDao.insertAssets(response.outletAssets!);
        }
      }).then((value) {
        LookUpData lookUpData = LookUpData();

        lookUpData.packages = response.packages;
        lookUpData.brands = response.brands;
        lookUpData.products = response.products;
        lookUpData.vpo_classification = response.vpo_classification;
        lookUpData.outlet_classification = response.outlet_classification;
        lookUpData.trade_classification = response.trade_classification;
        lookUpData.channels = response.channels;
        lookUpData.cities = response.cities;
        lookUpData.outletTypes = response.outletTypes;
        lookUpData.market_types = response.market_types;

        _homeDao.insertPackagesAndBrands(lookUpData);

        _preferenceUtil.saveConfig(response.configuration);
      }).whenComplete(() {
        _preferenceUtil.setMVTargetOutlets(response.targetOutlets ?? 0);
        fetchWorkWith(loadedOnDayStart);
      }).onError((error, stackTrace) {
        setLoading(false);
        onError(error.toString());
      });
    } catch (e) {
      setLoading(false);
      onError(e.toString());
    }
  }

  Future<void> clearDb(MainDao homeDao) async {
    homeDao.deleteAllRoutes();
    homeDao.deleteAllOutlets();
    homeDao.deleteAllAsset();
    homeDao.deleteAllAssetReason();
    homeDao.deleteAllDesignation();
    homeDao.deleteAllDistribution();
    homeDao.deleteMarketVisiDistribution();
    homeDao.deleteAllPackMapping();
    homeDao.deleteAllTask();
    homeDao.deleteAllTaskType();
  }

  void fetchWorkWith(bool isStart) async {
    try {
      String accessToken = _preferenceUtil.getToken();

      final response = await _apiService.loadWorkWithData(accessToken);

      if (response.status == RequestStatus.SUCCESS) {
        var mainModel =
            WorkWithResponseModel.fromJson(jsonDecode(response.data));

        if (bool.parse(mainModel.success ?? "true")) {
          onWorkWithDataLoaded(mainModel, isStart);
        } else {
          setLoading(false);
          onError(mainModel.errorMessage.toString());
        }
      } else {
        setLoading(false);
        onError(response.message);
      }
    } catch (e) {
      setLoading(false);
      onError(e.toString());
    }
  }

  void setLoading(bool value) {
    _isLoading.value = value;
    _isLoading.refresh();
  }

  void onWorkWithDataLoaded(
      WorkWithResponseModel response, bool isStart) async {
    try {
      clearPSRDb(_homeDao).then((value) {
        if (response.routes != null) {
          _homeDao.insertWWRoutes(response.routes!);
        }
      }) /*then((value) {
        if (response.outlets != null) {
          _homeDao.insertWWOutlets(response.outlets!);
        }
      })*/
          .then((value) {
        if (response.taskTypes != null) {
          _homeDao.insertWWTaskTypes(response.taskTypes!);
        }
      }).then((value) {
        if (response.distributions != null) {
          _homeDao.insertWWDistribution(response.distributions!);
        }
      }).then((value) {
        if (response.tasks != null) {
          _homeDao.insertWWTasks(response.tasks!);
        }
      }).then((value) {
        if (response.psrs != null) {
          _homeDao.insertPsr(response.psrs!);
        }
      }).whenComplete(() {
        setLoading(false);
        setMessage(Constants.LOADED);
        // _onDayStart.value = isStart;
        // getRoutesModel(isStart);
        _preferenceUtil.setWWTargetOutlets(response.getTargetOutlets() ?? 0);
      }).onError((error, stackTrace) {
        setLoading(false);
        onError(error.toString());
      });
    } catch (e) {
      setLoading(false);
      onError(e.toString());
    }
  }

  Future<void> clearPSRDb(MainDao homeDao) async {
    homeDao.deleteAllWWDistribution();
    homeDao.deleteAllWWRoutes();
    homeDao.deleteAllWWOutlets();
    homeDao.deleteAllPsr();
    homeDao.deleteAllWWTask();
    homeDao.deleteAllWWTaskType();
  }

  Future<RxBool> logout() async {
    _isLoggedOut.value = false;
    setLoading(true);

    try {
      clearDb(_homeDao).then((value) => clearPSRDb(_homeDao).then((value) {
            _homeDao.deleteAllPreWorkWith();
            _homeDao.deleteAllPostWorkWith();
            _homeDao.deleteAllMarketSurveys();
          }).then((value) {
            _preferenceUtil.clearAllPreferences();
          }).whenComplete(() {
            SurveySingletonModel.getInstance().reset();
            WorkWithSingletonModel.getInstance().reset();
            _isLoggedOut.value = true;
          }));
    } catch (e) {
      setLoading(false);
      onError(e.toString());
    }

    return _isLoggedOut;
  }

  void marketVisitOutletByRouteId(int routeId) async {
    setLoading(true);
    NetworkManager.getInstance().isConnectedToInternet().then((isOnline) async {
      if (isOnline) {
        try {
          String accessToken = _preferenceUtil.getToken();

          final response = await _apiService.marketVisitOutletByRouteId(
              accessToken, routeId, true);

          if (response.status == RequestStatus.SUCCESS) {
            setLoading(false);
            //parse json data to dart model
            MainModel outlets = MainModel.fromJson(jsonDecode(response.data));
            if (bool.parse(outlets.success ?? "true")) {
              if (outlets.outlets != null) {
                _homeDao.insertOutlets(outlets.outlets
                    ?.map((e) => Outlet.fromJson(e.toJson()))
                    .toList());
                setMarketVisitsLoaded(true);
              }
            } else {
              onError(outlets.errorMessage);
            }
          } else {
            setLoading(false);
            onError(response.message);
          }
        } catch (e) {
          setLoading(false);
          onError(e.toString());
        }
      } else {
        setLoading(false);
        onError("No Internet Connection");
      }
    });
  }

  void workWithOutletByRouteId(int routeId) async {
    setLoading(true);
    NetworkManager.getInstance().isConnectedToInternet().then((isOnline) async {
      if (isOnline) {
        try {
          String accessToken = _preferenceUtil.getToken();

          final response = await _apiService.workWithOutletByRouteId(
              accessToken, routeId, false);

          if (response.status == RequestStatus.SUCCESS) {
            setLoading(false);
            //parse json data to dart model
            WorkWithResponseModel outlets =
                WorkWithResponseModel.fromJson(jsonDecode(response.data));
            if (bool.parse(outlets.success ?? "true")) {
              if (outlets.outlets != null) {
                _homeDao.insertWWOutlets(outlets.outlets!
                    .map((e) => WOutlet.fromJson(e.toJson()))
                    .toList());
                setWorkWithOutletsLoaded(true);
              }
            } else {
              onError(outlets.errorMessage);
            }
          } else {
            setLoading(false);
            onError(response.message);
          }
        } catch (e) {
          onError(e.toString());
        }
      } else {
        setLoading(false);
        onError("No Internet Connection");
      }
    });
  }

  Future<Merchandise> findMerchandise(int outletId) {
    return _homeDao.findMerchandiseByOutletId(outletId);
  }

  //return the value notifiers
  RxBool isLoading() => _isLoading;

  RxBool startDay() => _onDayStart;

  Rx<Event<String>> getProgressMsg() => _progressMsg;

  RxBool getUploadCompleted() => _uploadCompleted;

  RxBool isMarketVisitOutletsLoaded() => _isMarketVisitsOutletsLoaded;

  RxBool isWorkWithOutletsLoaded() => _isWorkWithOutletsLoaded;

  Rx<Event<String>> getMessage() => _msg;

  Rx<RoutesModel> getRoutesLiveData() => _routesModelMutableLiveData;

  bool isDayStarted() {
    return _preferenceUtil.getWorkSyncData().isDayStarted;
  }

  Future<List<MarketVisit>> dayEndResults() {
    return _homeDao.dayEndQuery();
  }

  void setUploadCompleted(bool value) {
    _uploadCompleted.value = value;
    _uploadCompleted.refresh();
  }

  Future<List<MarketVisit>> getAllSurveyItems() => _homeDao.getMarketSurveys();

  Future<List<WorkWithPre>> getAllPreWork() => _homeDao.getAllPreWork();

  Future<List<WorkWithPost>> getAllPostWork() => _homeDao.getAllPostWork();

  uploadAllMarketVisitSurvey() async {
    setLoading(true);
    _homeDao
        .getUnSyncedSurveys()
        .then((marketVisits) => saveSurveyObservable(marketVisits))
        .then((marketVisits) async {
      _remainingTasks = _totalTasks = marketVisits.length;

      for (MarketVisit marketVisit in marketVisits) {
        _remainingTasks = _remainingTasks - 1;
        if (marketVisit.getSynced()) {
          _homeDao.updateMarketSurvey(marketVisit);
          Outlet outlet = await _homeDao.findOutletById(marketVisit.outletId);
          outlet.synced = true;
          _homeDao.updateOutlet(outlet);
          if (_totalTasks > 0) {
            //TODO Show user task count and total count
            String message =
                "Uploading  Task ${_totalTasks - _remainingTasks + 1}";
            //msg.postValue(new Event<>("Uploading  Task "+(totalTasks-remainingTasks+1)+""));
            setProgressMsg(message);
          }
        }
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      setProgressMsg("");
      onError(error.toString());
      setUploadCompleted(false);
    }).whenComplete(() {
      setProgressMsg("");
      // setMessage("Market Data Upload Completed");

      handlePreWorkWith();
    });
  }

  void handlePreWorkWith() {
    _homeDao
        .getAllUnSyncedPreWork()
        .then((workWithPre) => savePreWorkObservable(workWithPre))
        .then((workWiths) async {
      _remainingTasks = _totalTasks = workWiths.length;

      for (WorkWithPre workWithPre in workWiths) {
        _remainingTasks = _remainingTasks - 1;
        if (workWithPre.getSynced()) {
          _homeDao.updatePreWorkWith(workWithPre);
          if (workWithPre.outletId != null) {
            _homeDao.deleteAllMerchandiseByOutlet(workWithPre.outletId!);
          }
          if (_totalTasks > 0) {
            //TODO Show user task count and total count
            String message =
                "Uploading  Task ${_totalTasks - _remainingTasks + 1}";
            //msg.postValue(new Event<>("Uploading  Task "+(totalTasks-remainingTasks+1)+""));
            setProgressMsg(message);
          }
        }
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      setProgressMsg("");
      onError(error.toString());
      setUploadCompleted(false);
    }).whenComplete(() {
      setProgressMsg("");
      // setMessage("Pre Work With Completed");
      handlePostWorkWith();
    });
  }

  void handlePostWorkWith() {
    _homeDao
        .getAllUnSyncedPostWork()
        .then((workWiths) => saveWorkObservable(workWiths))
        .then((workWiths) async {
      _remainingTasks = _totalTasks = workWiths.length;

      for (WorkWithPost workWithPost in workWiths) {
        _remainingTasks = _remainingTasks - 1;
        if (workWithPost.getSynced()) {
          _homeDao.updateWorkWith(workWithPost);
          WOutlet outlet =
              await _homeDao.findWOutletById(workWithPost.outletId);
          outlet.surveyTaken = true;
          _homeDao.updateWOutlet(outlet);

          _homeDao.deleteAllMerchandiseByOutlet(workWithPost.outletId);
        }
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      onError(error.toString());
      setUploadCompleted(false);
    }).whenComplete(() {
      setLoading(false);
      // setMessage("Work with Data Upload Completed");
      setUploadCompleted(true);
    });
  }

  Future<List<MarketVisit>> saveSurveyObservable(
      List<MarketVisit> marketVisits) async {
    for (MarketVisit marketVisit in marketVisits) {
      if (marketVisit.data != null) {
        SurveyModel dataModel =
            SurveyModel.fromJson(jsonDecode(marketVisit.data!));

        try {
          // set merchandise images in work with model
          Merchandise? merchandises =
              await findMerchandise(dataModel.getOutletId() ?? 0);
          List<MerchandisingImage> merchandisingImages = [];

          if (merchandises.merchandiseImages != null) {
            for (MerchandisingImage merchandisingImage
                in merchandises.merchandiseImages!) {
              merchandisingImage.image =
                  await Util.convertImageToUtf8(merchandisingImage.path ?? "");
              merchandisingImages.add(merchandisingImage);
            }
          }
          dataModel.setMerchandisingImages(merchandisingImages);
        } catch (e) {
          debugPrint(e.toString());
        }

        String finalJson = jsonEncode(dataModel.toJson());
        debugPrint("after: $finalJson");

        final accessToken = _preferenceUtil.getToken();

        final response = await _apiService.saveSurvey(dataModel, accessToken);

        if (response.status == RequestStatus.SUCCESS) {
          SurveyModel surveyModel =
              SurveyModel.fromJson(json.decode(response.data));
          if (bool.parse(surveyModel.success ?? "true")) {
            marketVisit.synced = true;
            if (surveyModel.getOutletId() != null) {
              _homeDao.deleteAllMerchandiseByOutlet(surveyModel.getOutletId()!);
              deleteAllImageFiles(surveyModel.getOutletId()!);
            }
          } else {
            setLoading(false);
            onError(surveyModel.errorMessage);
          }
        } else {
          setLoading(false);
          onError(response.message);
        }
      }
    }

    return marketVisits;
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

  Future<List<WorkWithPre>> savePreWorkObservable(
      List<WorkWithPre> workWithPres) async {
    for (WorkWithPre workWithPre in workWithPres) {
      if (workWithPre.data != null) {
        WorkWithSingletonModel workWithSingletonModel =
            WorkWithSingletonModel.fromJson(jsonDecode(workWithPre.data!));

        try {
          // set merchandise images in work with model
          Merchandise? merchandises =
              await findMerchandise(workWithSingletonModel.getOutletId() ?? 0);
          List<MerchandisingImage> merchandisingImages = [];

          if (merchandises.merchandiseImages != null) {
            for (MerchandisingImage merchandisingImage
                in merchandises.merchandiseImages!) {
              merchandisingImage.image =
                  await Util.convertImageToUtf8(merchandisingImage.path ?? "");
              merchandisingImages.add(merchandisingImage);
            }
          }
          workWithSingletonModel.setMerchandisingImages(merchandisingImages);
        } catch (e) {
          debugPrint(e.toString());
        }
        String finalJson = jsonEncode(workWithSingletonModel.toJson());
        debugPrint("after: $finalJson");
        final accessToken = _preferenceUtil.getToken();
        final response =
            await _apiService.saveWorkWith(workWithSingletonModel, accessToken);
        if (response.status == RequestStatus.SUCCESS) {
          BaseResponse baseResponse =
              BaseResponse.fromJson(json.decode(response.data));
          if (bool.parse(baseResponse.success ?? "true")) {
            workWithPre.synced = true;
            if (workWithSingletonModel.getOutletId() != null) {
              _homeDao.deleteAllMerchandiseByOutlet(
                  workWithSingletonModel.getOutletId()!);
              deleteAllImageFiles(workWithSingletonModel.getOutletId()!);
            }
          } else {
            setLoading(false);
            onError(baseResponse.errorMessage);
          }
        } else {
          setLoading(false);
          onError(response.message);
        }
      }
    }
    return workWithPres;
  }

  Future<List<WorkWithPost>> saveWorkObservable(
      List<WorkWithPost> workWiths) async {
    for (WorkWithPost workWithPost in workWiths) {
      if (workWithPost.data != null) {
        WorkWithSingletonModel workWithSingletonModel =
            WorkWithSingletonModel.fromJson(jsonDecode(workWithPost.data!));
        try {
          /* set merchandise images in work with model */
          Merchandise? merchandises =
              await findMerchandise(workWithSingletonModel.getOutletId() ?? 0);
          List<MerchandisingImage> merchandisingImages = [];
          if (merchandises.merchandiseImages != null) {
            for (MerchandisingImage merchandisingImage
                in merchandises.merchandiseImages!) {
              merchandisingImage.image =
                  await Util.convertImageToUtf8(merchandisingImage.path ?? "");
              merchandisingImages.add(merchandisingImage);
            }
          }
          workWithSingletonModel.setMerchandisingImages(merchandisingImages);
        } catch (e) {
          debugPrint(e.toString());
        }

        String finalJson = jsonEncode(workWithSingletonModel.toJson());
        debugPrint("after: $finalJson");

        final accessToken = _preferenceUtil.getToken();

        final response =
            await _apiService.saveWorkWith(workWithSingletonModel, accessToken);

        if (response.status == RequestStatus.SUCCESS) {
          BaseResponse baseResponse =
              BaseResponse.fromJson(json.decode(response.data));
          if (bool.parse(baseResponse.success ?? "true")) {
            workWithPost.synced = true;
            if (workWithSingletonModel.getOutletId() != null) {
              _homeDao.deleteAllMerchandiseByOutlet(
                  workWithSingletonModel.getOutletId()!);
              deleteAllImageFiles(workWithSingletonModel.getOutletId()!);
            }
          } else {
            setLoading(false);
            onError(baseResponse.errorMessage);
          }
        } else {
          setLoading(false);
          onError(response.message);
        }
      }
    }
    return workWiths;
  }

  void setMarketVisitsLoaded(bool value) {
    _isMarketVisitsOutletsLoaded.value = value;
    _isMarketVisitsOutletsLoaded.refresh();
  }

  void setWorkWithOutletsLoaded(bool value) {
    _isWorkWithOutletsLoaded.value = value;
    _isWorkWithOutletsLoaded.refresh();
  }

  void setRoutesLiveData(RoutesModel routesModel) {
    _routesModelMutableLiveData(routesModel);
    _routesModelMutableLiveData.refresh();
  }

  void getRoutesModel(bool isStart) async {
    NetworkManager.getInstance().isConnectedToInternet().then((isOnline) async {
      if (isOnline) {
        try {
          PackageInfo packageInfo = await PackageInfo.fromPlatform();

          // Map<String, dynamic> map = {};
          // map['operationTypeId'] = isStart ? "1" : "2";
          // map['statusForApp'] = "2";
          // map['appVersion'] = "2";

          String accessToken = _preferenceUtil.getToken();

          final response = await _apiService.getRoutesModel(
              accessToken, packageInfo.buildNumber);

          if (response.status == RequestStatus.SUCCESS) {
            setLoading(false);

            //parse data into model
            if (response.data != "") {
              RoutesModel routesModel =
                  RoutesModel.fromJson(jsonDecode(response.data));
              if (bool.parse(routesModel.success ?? "true")) {
                if (routesModel.outlets != null) {
                  setMessage(Constants.LOADED);
                  // _onDayStart.value = isStart;
                  setRoutesLiveData(routesModel);
                } else {
                  onError(routesModel.errorMessage);
                }
              } else {
                setLoading(false);
                onError(response.message);
              }
            } else {
              setMessage(Constants.LOADED);
              _onDayStart.value = isStart;
            }
          }
        } catch (e) {
          setLoading(false);
          setMessage(Constants.LOADED);
          _onDayStart.value = isStart;
          onError(Constants.GENERIC_ERROR2);
        }
      }
    });
  }

  void deleteTables(bool getRouteTables) async {
    if (getRouteTables) {
      _homeDao.deleteDocuments();
      _homeDao.deleteOutlets();
    } else {}
  }

  void addDocuments(List<DocumentTable>? documents) {
    _homeDao.insertDocuments(documents);
  }

  void addOutlets(List<OutletTable>? outlets) {
    _homeDao.insertOutletTable(outlets);
  }
}
