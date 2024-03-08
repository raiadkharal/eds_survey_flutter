import 'dart:convert';

import 'package:eds_survey/models/work_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtil {
  static PreferenceUtil? _instance;

  final SharedPreferences _sharedPreferences;
  static const String _keyToken = "token";
  static const String _keyUsername = "username";
  static const String _keyPassword = "password";
  static const String _keySyncData = "sync_date";

  PreferenceUtil._(this._sharedPreferences);

  static Future<PreferenceUtil> getInstance() async {
    if (_instance == null) {
      return _instance =
          PreferenceUtil._(await SharedPreferences.getInstance());
    } else {
      return _instance!;
    }
  }

  void clearAllPreferences() {
    _sharedPreferences.clear();
    _sharedPreferences.commit();
  }

  void saveToken(String? token) {
    _sharedPreferences.setString(_keyToken, token!);
  }

  String getToken() {
    return _sharedPreferences.getString(_keyToken) ?? "";
  }

  void saveUserName(String? username) {
    _sharedPreferences.setString(_keyUsername, username!);
  }

  String getUsername() {
    return _sharedPreferences.getString(_keyUsername) ?? "";
  }

  void savePassword(String? password) {
    _sharedPreferences.setString(_keyPassword, password!);
  }

  String getPassword() {
    return _sharedPreferences.getString(_keyPassword) ?? "";
  }

  WorkStatus getWorkSyncData() {
    final statusStr = _sharedPreferences.getString(_keySyncData) ?? "";
    
    if(statusStr.isEmpty){
      return WorkStatus(0);
    }
    
    // Parse string to work status object and return
    WorkStatus workStatus = WorkStatus.fromJson(jsonDecode(statusStr));
    return workStatus;
  }

  void saveWorkSyncData(WorkStatus status) {
    String statusStr = jsonEncode(status);

    _sharedPreferences.setString(_keySyncData, statusStr);
  }
}
