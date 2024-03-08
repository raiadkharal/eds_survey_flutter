import 'dart:convert';

import 'package:eds_survey/data_source/remote/BaseApiService.dart';
import 'package:eds_survey/data_source/remote/response/ApiResponse.dart';
import 'package:http/http.dart' as http;

class ApiService extends ApiInterface {
  static const _baseUrl = "http://101.50.85.136:84/api/";

  final _httpClient = http.Client();

  @override
  Future<ApiResponse> getAccessToken(String type, String username,
      String password) async {
    Map<String, dynamic> jsonMap = {
      'grant_type': type,
      'username': username,
      'password': password
    };

    //parse url string to Uri
    var url = Uri.parse("${_baseUrl}token");

    return await _httpClient.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: jsonMap,
      encoding: Encoding.getByName("utf-8"),
    ).then((response) {
      return handleApiResponse(response);
    }).onError((error, stackTrace) {
      return ApiResponse.error(error.toString());
    });
  }

  @override
  Future<ApiResponse> updateStartEndStatus(Map<String, dynamic> params,
      String accessToken) async {
    //parse url string to Uri
    var url = Uri.parse("${_baseUrl}api/AppOpertion/LogStartEnd");

    return await _httpClient.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Bearer $accessToken"
      },
      body: params,
      encoding: Encoding.getByName("utf-8"),
    ).then((response) {
      return handleApiResponse(response);
    }).onError((error, stackTrace) {
      return ApiResponse.error(error.toString());
    });
  }

  ApiResponse handleApiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponse.success(response.body);
      case 400:
        return ApiResponse.error("Username or Password is incorrect");
      case 408:
        return ApiResponse.error("Request Timed out");
      case 500:
        return ApiResponse.error("Internal Server Error");
      default:
        return ApiResponse.error(response.reasonPhrase);
    }
  }

}
