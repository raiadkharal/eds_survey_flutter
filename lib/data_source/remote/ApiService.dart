import 'dart:convert';

import 'package:eds_survey/data/WorkWithSingletonModel.dart';
import 'package:eds_survey/data/models/SurveyModel.dart';
import 'package:eds_survey/data_source/remote/BaseApiService.dart';
import 'package:eds_survey/data_source/remote/response/ApiResponse.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:http/http.dart' as http;

import '../../data/models/Request.dart';

class ApiService extends ApiInterface {

  final _httpClient = http.Client();

  @override
  Future<ApiResponse> getAccessToken(
      String type, String username, String password) async {
    Map<String, dynamic> bodyJson = {
      'grant_type': type,
      'userName': username,
      'password': password
    };

    final headers = {
      "content-type" : "application/json",
      "accept" : "application/json",
    };

    return makePostRequest("token",jsonEncode(bodyJson), headers, null);
  }

  @override
  Future<ApiResponse> updateStartEndStatus(
      Map<String, dynamic> body, String accessToken) async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    return makePostRequest("AppOpertion/LogStartEnd", jsonEncode(body), headers, null);
  }

  @override
  Future<ApiResponse> loadData(String accessToken) async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    return makeGetRequest("MarketVisit/Get", headers, null);
  }

  @override
  Future<ApiResponse> loadWorkWithData(String accessToken) async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    return makeGetRequest("WorkWith/Get", headers, null);
  }

  @override
  Future<ApiResponse> workWithOutletByRouteId(
      String accessToken, int routeId, bool isMarketVisit) async {
    final queryParameters = {
      'routeId': "$routeId",
      'isMarketVisit': "$isMarketVisit",
    };

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    return makeGetRequest(
        "MarketVisit/GetOutletsByRouteId", headers, queryParameters);
  }

  @override
  Future<ApiResponse> marketVisitOutletByRouteId(
      String accessToken, int routeId, bool isMarketVisit) async {
    final queryParameters = {
      'routeId': "$routeId",
      'isMarketVisit': "$isMarketVisit",
    };

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    return makeGetRequest(
        "MarketVisit/GetOutletsByRouteId", headers, queryParameters);
  }



  @override
  Future<ApiResponse> saveWorkWith(
      WorkWithSingletonModel workWithModel, String accessToken) {
    final headers = {
      "Content-Type": " application/json;charset=UTF-8",
      "Authorization": "Bearer $accessToken"
    };

    return makePostRequest(
        "WorkWith/PostWorkWith", json.encode(workWithModel.toJson()), headers, null);
  }

  @override
  Future<ApiResponse> saveSurvey(SurveyModel surveyModel, String accessToken) {
    final headers = {
      "Content-Type": " application/json;charset=UTF-8",
      "Authorization": "Bearer $accessToken"
    };

    return makePostRequest("MarketVisit/PostOutletMarketVisit",
        json.encode(surveyModel.toJson()), headers, null);
  }


  @override
  Future<ApiResponse> getRoutesModel(String accessToken, String appVersion) async{
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    };

    final queryParameters = {
      'appVersion': appVersion,
    };

    return makeGetRequest("AMRoute/GetRouteInformation", headers, queryParameters);
  }


  @override
  Future<ApiResponse> postOutletRequest(String accessToken, Request request) {
    final headers = {
      "Content-Type": "application/json;charset=UTF-8",
      "Authorization": "Bearer $accessToken"
    };

    return makePostRequest("AMRequest/PostOutletRequest", jsonEncode(request.toJson()), headers, null);
  }





  @override
  Future<ApiResponse> makeGetRequest(String path, Map<String, String> headers,
      Map<String, dynamic>? queryParameters) async {
    try {
      Uri uri;
      if (queryParameters != null) {
        //parse url string to Uri and add query parameters to Uri
        uri = Uri.parse(Constants.baseUrl + path)
            .replace(queryParameters: queryParameters);
      } else {
        //parse url string to Uri
        uri = Uri.parse(Constants.baseUrl + path);
      }

      // make request to the server
      final response = await _httpClient.get(
        uri,
        headers: headers,
      );
      return handleApiResponse(response);
    } catch (error) {
      return ApiResponse.error(error.toString());
    }
  }

  @override
  Future<ApiResponse> makePostRequest(
      String path,
      Object body,
      Map<String, String> headers,
      Map<String, dynamic>? queryParameters) async {
    try {
      Uri uri;
      if (queryParameters != null) {
        //parse url string to Uri and add query parameters to Uri
        uri = Uri.parse(Constants.baseUrl + path)
            .replace(queryParameters: queryParameters);
      } else {
        //parse url string to Uri
        uri = Uri.parse(Constants.baseUrl + path);
      }

      final response = await _httpClient.post(
        uri,
        headers: headers,
        body: body,
        encoding: Encoding.getByName("utf-8"),
      );
      return handleApiResponse(response);
    } catch (error) {
      return ApiResponse.error(error.toString());
    }
  }

  // api response handling
  ApiResponse handleApiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return ApiResponse.success(response.body);
      case 401:
        return ApiResponse.error("UnAuthorized");
      case 400:
        return ApiResponse.error("Username or Password Incorrect");
      case 408:
        return ApiResponse.error("Request Timed out");
      case 500:
        return ApiResponse.error("Internal Server Error");
      default:
        return ApiResponse.error(Constants.GENERIC_ERROR);
    }
  }
}
