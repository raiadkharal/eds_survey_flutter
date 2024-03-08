import 'dart:convert';

import 'package:eds_survey/ui/login/LoginRepository.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/LoggedInUser.dart';

class LoginViewModel extends ChangeNotifier {
  late final LoginRepository repository;
  bool isLoading = false;

  LoginViewModel() {
    repository = LoginRepository.getInstance();
  }

  void login(String username, String password,
      Function(bool success) successCallback) {
    setLoading(true);
    repository.login(
      username,
      password,
      (response) {
        setLoading(false);
        if (response.status == RequestStatus.SUCCESS) {
          LoggedInUser user = response.data;
          repository.setLoggedInUser(user);
          successCallback(true);
        } else {
          Fluttertoast.showToast(msg: response.message.toString());
        }
      },
    );
  }


  Future<bool> isAlreadyLoggedIn() async{
    PreferenceUtil preferenceUtil = await PreferenceUtil.getInstance();
    return preferenceUtil.getToken().isNotEmpty;
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
