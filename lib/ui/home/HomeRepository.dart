import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:eds_survey/data_source/remote/ApiService.dart';
import 'package:eds_survey/data_source/remote/response/ApiResponse.dart';
import 'package:eds_survey/models/LogModel.dart';
import 'package:eds_survey/models/work_status.dart';
import 'package:eds_survey/ui/home/HomeViewModel.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../models/TokenResponse.dart';
import '../../utils/Event.dart';

class HomeRepository {
  static HomeRepository? _instance;
  late final ApiService _apiService;
  late ValueNotifier<bool> _isLoading;
  late ValueNotifier<bool> _onDayStartNotifier;
  late ValueNotifier<bool> _onDayEndNotifier;
  late var _workWithOutlets;
  late var _marketVisitOutlets;
  late ValueNotifier<Event<String>> _msg;
  late ValueNotifier<Event<String>> _progressMsg;
  late ValueNotifier<bool> _uploadCompleted;

  static HomeRepository singleInstance() {
    _instance ??= HomeRepository();
    return _instance!;
  }

  HomeRepository() {
    _apiService = ApiService();
    _isLoading = ValueNotifier<bool>(false);
    _onDayStartNotifier = ValueNotifier<bool>(false);
    _onDayEndNotifier = ValueNotifier<bool>(false);
    _uploadCompleted = ValueNotifier<bool>(false);
    _msg = ValueNotifier<Event<String>>(Event(""));
    _progressMsg = ValueNotifier<Event<String>>(Event(""));
  }

  void getToken() async {
    _isLoading.value = true;
    PreferenceUtil preferenceUtil = await PreferenceUtil.getInstance();
    String username = preferenceUtil.getUsername();
    String password = preferenceUtil.getPassword();

    _apiService.getAccessToken("password", username, password).then((response) {
      //parse response json to dart model
      TokenResponse tokenResponse =
          TokenResponse.fromJson(jsonDecode(response.data));

      //save access token to local cache
      if (tokenResponse.accessToken != null) {
        preferenceUtil.saveToken(tokenResponse.accessToken);
      }

      updateWorkWithStatus(true);
    }).onError((error, stackTrace) {
      _isLoading.value = false;
      if (error is HttpException || error is SocketException) {
        _msg.value = Event(Constants.NETWORK_ERROR);
      } else {
        _msg.value = Event(error.toString());
      }
    });
  }

  void updateWorkWithStatus(bool isStart) async {
    _isLoading.value = true;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    PreferenceUtil preferenceUtil = await PreferenceUtil.getInstance();

    Map<String, dynamic> map = {};
    map['operationTypeId'] = isStart ? "1" : "2";
    map['statusForApp'] = "2";
    map['appVersion'] = "2";

    String accessToken = preferenceUtil.getToken();
    _apiService.updateStartEndStatus(map,accessToken).then((response) {
      _isLoading.value = false;
      LogModel logModel = LogModel.fromJson(jsonDecode(response.data));

      if(response.status == RequestStatus.SUCCESS){
        if (bool.parse(logModel.success)) {
          WorkStatus status = preferenceUtil.getWorkSyncData();
          status.dayStarted = 1;
          status.syncDate = logModel.startDay!;
          preferenceUtil.saveWorkSyncData(status);
          _onDayStartNotifier.value = isStart;
          if (isStart) {
            // fetchData(isStart);
          }
        } else {
          _msg.value = Event((logModel.errorCode == 1 || logModel.errorCode == 2)
              ? logModel.errorMessage ?? ""
              : Constants.GENERIC_ERROR);
        }
      }else{
        Fluttertoast.showToast(msg: response.message.toString());
      }

    }).onError((error, stackTrace) {
      _isLoading.value = false;
      _msg.value = Event(error.toString());
      Fluttertoast.showToast(msg: _msg.value.peekContent());
    });
  }

  ValueNotifier<bool> isLoading() => _isLoading;

  ValueNotifier<bool> startDay() => _onDayStartNotifier;

  ValueNotifier<bool> endDay() => _onDayEndNotifier;

  ValueNotifier<Event<String>> getProgressMsg() => _progressMsg;

  ValueNotifier<bool> getUploadCompleted() => _uploadCompleted;

  ValueNotifier<Event<String>> getMessage() => _msg;

  void setStartDay() {
    _onDayStartNotifier.value = false;
  }
}
