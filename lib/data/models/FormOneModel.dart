import 'package:json_annotation/json_annotation.dart';

import 'PJPModel.dart';

part 'FormOneModel.g.dart';

@JsonSerializable()
class FormOneSingletonModel {
  int? outletReqId;
  int? outletId;
  String? outletCode;
  String? outletName;
  String? outletAddress;
  String? landmark;
  double? radius;
  String? vpoClassification;
  int? vpoClassificationId;
  double? lat;
  double? lng;
  int? cityId;
  int? routeId;
  int? organizationId;
  int? distributionId;
  bool? competitorsCooler;
  bool? journeyPlan;
  int? marketTypeId;
  int? tradeClassificationId;
  int? outletClassificationId;
  int? channelId;
  int? agreedSalesVolume;
  String? comments;
  String? marketType;
  String? city;
  String? routes;
  String? outletType;
  String? tradeClassification;
  String? outletClassification;
  String? channelType;
  List<PJPModel>? pjpModels;
  int? requestId;
  int? requestTypeId;
  int? requestFormId;
  int? workFlowId;
  int? outletTypeId;

  static FormOneSingletonModel? _instance;

  static FormOneSingletonModel getInstance() {
    _instance ??= FormOneSingletonModel._internal();
    return _instance!;
  }

  FormOneSingletonModel._internal();

  factory FormOneSingletonModel.fromJson(Map<String, dynamic> json) =>
      _$FormOneSingletonModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormOneSingletonModelToJson(this);
}
