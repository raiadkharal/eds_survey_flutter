import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eds_survey/data/WorkWithSingletonModel.dart';
import 'package:eds_survey/data_source/remote/response/ApiResponse.dart';
import 'package:http/http.dart' as http;
import '../../data/models/Request.dart';
import '../../data/models/SurveyModel.dart';
import '../../data/models/TokenResponse.dart';

abstract class ApiInterface {
  Future<ApiResponse> getAccessToken(
      String type, String username, String password);

  Future<ApiResponse> updateStartEndStatus(
      Map<String, int> body, String accessToken);

  Future<ApiResponse> loadData(String accessToken);

  Future<ApiResponse> loadWorkWithData(String accessToken);

  Future<ApiResponse> workWithOutletByRouteId(
      String accessToken, int routeId, bool isMarketVisit);

  Future<ApiResponse> marketVisitOutletByRouteId(
      String accessToken, int routeId, bool isMarketVisit);

  Future<ApiResponse> saveWorkWith(
      WorkWithSingletonModel workWithModel, String accessToken);

  Future<ApiResponse> saveSurvey(SurveyModel surveyModel, String accessToken);

  Future<ApiResponse> getRoutesModel(String accessToken,String appVersion);

  Future<ApiResponse> postOutletRequest(String accessToken,Request request);







  // Generic methods for Get and Post Request
  Future<ApiResponse> makeGetRequest(String path, Map<String, String> headers,
      Map<String, dynamic>? queryParameters);

  Future<ApiResponse> makePostRequest(String path, Object body,
      Map<String, String> headers, Map<String, dynamic>? queryParameters);
}
