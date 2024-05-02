import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eds_survey/data_source/remote/ApiService.dart';
import 'package:eds_survey/data_source/remote/response/ApiResponse.dart';
import 'package:eds_survey/data/models/TokenResponse.dart';
import 'package:eds_survey/ui/login/LoginResult.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/NetworkManager.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/models/LoggedInUser.dart';

class LoginRepository {
  final ApiService _apiService;
  static LoginRepository? _instance;
  final PreferenceUtil _preferenceUtil;

  LoggedInUser? _user;

  LoginRepository._(this._apiService, this._preferenceUtil);

  static LoginRepository getInstance(ApiService apiService,PreferenceUtil preferenceUtil) {
    if (_instance == null) {
      return _instance = LoginRepository._(apiService,preferenceUtil);
    } else {
      return _instance!;
    }
  }

  void login(String username, String password,
      Function(ApiResponse response) loginResultCallback) {
    NetworkManager.getInstance().isConnectedToInternet().then((isOnline) async {
      if (isOnline) {
        //get api response
        ApiResponse response =
            await _apiService.getAccessToken("password", username, password);

        if (response.status == RequestStatus.SUCCESS) {
          //parse response json to dart model
          try {
            TokenResponse tokenResponse =
                TokenResponse.fromJson(jsonDecode(response.data));

            //create loggedInUser object
            LoggedInUser loggedInUser = LoggedInUser(
                username, password, tokenResponse.accessToken ?? "");

            //pass user data to callback
            loginResultCallback(ApiResponse.success(loggedInUser));
          } catch (e) {
            loginResultCallback(ApiResponse.error(e.toString()));
          }
        } else {
          loginResultCallback(ApiResponse.error(response.message));
        }
      } else {
        loginResultCallback(ApiResponse.error("No Internet Connection"));
      }
    });
  }

  void setLoggedInUser(LoggedInUser user) async {
    _user = user;
    _preferenceUtil.clearAllPreferences();
    _preferenceUtil.saveToken(user.token);
    _preferenceUtil.saveUserName(user.displayName);
    _preferenceUtil.savePassword(user.password);
  }
}
