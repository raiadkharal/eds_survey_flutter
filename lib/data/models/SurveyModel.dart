import 'package:json_annotation/json_annotation.dart';

import '../../ui/market_visit/asset_verification/data/Asset.dart';
import '../../ui/market_visit/asset_verification/data/Image.dart';
import '../MarketVisitResponse.dart';
import '../db/entities/task.dart';
import 'BaseResponse.dart';
import 'MerchandisingImage.dart';

part 'SurveyModel.g.dart';

@JsonSerializable()
class SurveyModel extends BaseResponse {
  @JsonKey(includeIfNull: false)
  int? startDateTime;

  @JsonKey(includeIfNull: false)
  int? endDateTime;

  @JsonKey(includeIfNull: false)
  List<Asset>? assets;

  @JsonKey(includeIfNull: false)
  List<Task>? tasks;

  @JsonKey(includeIfNull: false)
  String? surveyWith;

  @JsonKey(includeIfNull: false)
  int? outletId;

  @JsonKey(includeIfNull: false)
  List<Image>? outletImages = [];

  @JsonKey(includeIfNull: false)
  List<MarketVisitResponse>? marketVisitResponses;

  @JsonKey(includeIfNull: false)
  List<MerchandisingImage>? merchandisingImages;

  @JsonKey(includeIfNull: false)
  double? latitude;

  @JsonKey(includeIfNull: false)
  double? longitude;

  @JsonKey(includeIfNull: false)
  double? outletLatitude;

  @JsonKey(includeIfNull: false)
  double? outletLongitude;

  @JsonKey(includeIfNull: false)
  double? distance;

  @JsonKey(includeIfNull: false)
  String? outletRemarks;

  @JsonKey(includeIfNull: false)
  String? feedBack;

  @JsonKey(includeIfNull: false)
  String? customerSignature;
  @JsonKey(includeIfNull: false)
  int? statusId;

  SurveyModel();

  void setStatusId(int statusId) {
    this.statusId = statusId;
  }

  int getStatusId() {
    return statusId ?? 0;
  }

  int? getStartDateTime() {
    return startDateTime;
  }

  void setStartDateTime(int? startDateTime) {
    this.startDateTime = startDateTime;
  }

  int? getEndDateTime() {
    return endDateTime;
  }

  void setEndDateTime(int? endDateTime) {
    this.endDateTime = endDateTime;
  }

  List<Asset>? getAssets() {
    return assets;
  }

  void setAssets(List<Asset>? assets) {
    this.assets = assets;
  }

  List<Task>? getTasks() {
    return tasks;
  }

  void setTasks(List<Task>? tasks) {
    this.tasks = tasks;
  }

  String? getSurveyWith() {
    return surveyWith;
  }

  void setSurveyWith(String? surveyWith) {
    this.surveyWith = surveyWith;
  }

  int? getOutletId() {
    return outletId;
  }

  double getOutletLatitude() {
    return outletLatitude ?? 0.0;
  }

  void setOutletLatitude(double outletLatitude) {
    this.outletLatitude = outletLatitude;
  }

  double getOutletLongitude() {
    return outletLongitude ?? 0.0;
  }

  void setOutletLongitude(double outletLongitude) {
    this.outletLongitude = outletLongitude;
  }

  void setOutletId(int? outletId) {
    this.outletId = outletId;
  }

  double getDistance() {
    return distance ?? 0.0;
  }

  void setDistance(double distance) {
    this.distance = distance;
  }

  List<Image> getOutletImages() {
    return outletImages ?? [];
  }

  void setOutletImages(List<Image> outletImages) {
    this.outletImages = outletImages;
  }

  List<MarketVisitResponse> getMarketVisitResponses() {
    return marketVisitResponses ?? [];
  }

  void setMarketVisitResponses(
      List<MarketVisitResponse>? marketVisitResponses) {
    this.marketVisitResponses = marketVisitResponses;
  }

  void setLatitude(double latitude) {
    this.latitude = latitude;
  }

  double getLatitude() {
    return latitude ?? 0.0;
  }

  void setLongitude(double longitude) {
    this.longitude = longitude;
  }

  double getLongitude() {
    return longitude ?? 0.0;
  }

  String getRemarks() {
    return outletRemarks ?? "";
  }

  void setRemarks(String remarks) {
    outletRemarks = remarks;
  }

  String getFeedBack() {
    return feedBack ?? '';
  }

  void setFeedBack(String feedBack) {
    this.feedBack = feedBack;
  }

  String getCustomerSignature() {
    return customerSignature ?? "";
  }

  void setCustomerSignature(String customerSignature) {
    this.customerSignature = customerSignature;
  }

  List<MerchandisingImage> getMerchandisingImages() {
    return merchandisingImages ?? [];
  }

  void setMerchandisingImages(List<MerchandisingImage>? merchandisingImages) {
    this.merchandisingImages = merchandisingImages;
  }

  factory SurveyModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyModelFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);
}
