import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eds_survey/data_source/remote/ApiService.dart';
import 'package:eds_survey/data_source/remote/response/ApiResponse.dart';
import 'package:eds_survey/models/LoggedInUser.dart';
import 'package:eds_survey/models/TokenResponse.dart';
import 'package:eds_survey/ui/login/LoginResult.dart';
import 'package:eds_survey/utils/NetworkManager.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  late final ApiService apiService;
  static LoginRepository? _instance;

  LoggedInUser? _user;

  LoginRepository._() {
    apiService = ApiService();
  }

  static LoginRepository getInstance() {
    if (_instance == null) {
      return _instance = LoginRepository._();
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
            await apiService.getAccessToken("password", username, password);

        //parse response json to dart model
        TokenResponse tokenResponse = TokenResponse.fromJson(jsonDecode(response.data));

        //create loggedInUser object
        LoggedInUser loggedInUser = LoggedInUser(username, password, tokenResponse.accessToken ?? "");

        //pass user data to callback
        loginResultCallback(ApiResponse.success(loggedInUser));

      } else {
        loginResultCallback(ApiResponse.error("No Internet Connection"));
      }
    });
  }

  void setLoggedInUser(LoggedInUser user) async {
    _user = user;
    PreferenceUtil preferenceUtil = await PreferenceUtil.getInstance();
    preferenceUtil.clearAllPreferences();
    preferenceUtil.saveToken(user.token);
    preferenceUtil.saveUserName(user.displayName);
    preferenceUtil.savePassword(user.password);
  }
}
