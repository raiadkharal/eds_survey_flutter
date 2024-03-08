import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eds_survey/data_source/remote/response/ApiResponse.dart';
import 'package:http/http.dart' as http;
import '../../models/TokenResponse.dart';

abstract class ApiInterface {
  Future<ApiResponse> getAccessToken(
      String type, String username, String password);

  Future<ApiResponse> updateStartEndStatus(Map<String, int> params,String accessToken);
}
