import 'dart:convert';

import 'package:eds_survey/ui/home/HomeScreen.dart';
import 'package:eds_survey/ui/login/LoginRepository.dart';
import 'package:eds_survey/ui/login/LoginScreen.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../data/models/LoggedInUser.dart';

class LoginViewModel extends GetxController {
  final LoginRepository _repository;
  final PreferenceUtil _preferenceUtil;
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  LoginViewModel(this._repository, this._preferenceUtil);

  void login(String username, String password,
      Function(bool success) successCallback) {
    setLoading(true);
    _repository.login(
      username,
      password,
      (response) {
        setLoading(false);
        if (response.status == RequestStatus.SUCCESS) {
          LoggedInUser user = response.data;
          _repository.setLoggedInUser(user);
          successCallback(true);
        } else {
          showToastMessage(response.message.toString());
        }
      },
    );
  }

  // @override
  // void onInit() {
  //   ever(isLoggedIn, fireRoute);
  //   isLoggedIn.value = _preferenceUtil.getToken().isNotEmpty;
  // }
  //
  // fireRoute(logged) {
  //   if (logged) {
  //     Get.off(const HomeScreen());
  //   } else {
  //     Get.off(LoginScreen());
  //   }
  // }

  bool isUserAlreadyLoggedIn() {
    // return false;
    return _preferenceUtil.getToken().isNotEmpty;
  }

  void setLoading(bool value) {
    isLoading.value = value;
    isLoading.refresh();
  }
}
