import 'package:eds_survey/data/db/entities/workwith/WOutlet.dart';
import 'package:eds_survey/data/models/BaseResponse.dart';
import 'package:eds_survey/data/models/WOutletModel.dart';
import 'package:json_annotation/json_annotation.dart';

import '../db/entities/workwith/Psr.dart';
import '../db/entities/workwith/WDistribution.dart';
import '../db/entities/workwith/WRoute.dart';
import '../db/entities/workwith/WTask.dart';
import '../db/entities/workwith/WTaskType.dart';

part 'WorkWithResponseModel.g.dart';

@JsonSerializable()
class WorkWithResponseModel extends BaseResponse {
  static WorkWithResponseModel? mainModel;

  static WorkWithResponseModel getInstance() {
    mainModel ??= WorkWithResponseModel();
    return mainModel!;
  }

  @JsonKey(name: 'targetOutlets')
  int? targetOutlets;
  @JsonKey(name: 'outlets')
  List<WOutletModel>? outlets;
  @JsonKey(name: 'routes')
  List<WRoute>? routes;
  @JsonKey(name: 'distributions')
  List<WDistribution>? distributions;
  @JsonKey(name: 'tasks')
  List<WTask>? tasks;
  @JsonKey(name: 'taskTypes')
  List<WTaskType>? taskTypes;
  @JsonKey(name: 'psr')
  List<Psr>? psrs;

  WorkWithResponseModel();

  factory WorkWithResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WorkWithResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WorkWithResponseModelToJson(this);

  List<WOutletModel>? getOutlets() {
    return outlets;
  }

  void setOutlets(List<WOutletModel>? outlets) {
    this.outlets = outlets;
  }

  List<WRoute>? getRoutes() {
    return routes;
  }

  void setRoutes(List<WRoute>? routes) {
    this.routes = routes;
  }

  List<WDistribution>? getDistributions() {
    return distributions;
  }

  void setDistributions(List<WDistribution>? distributions) {
    this.distributions = distributions;
  }

  List<WTask>? getTasks() {
    return tasks;
  }

  void setTasks(List<WTask>? tasks) {
    this.tasks = tasks;
  }

  List<Psr>? getPSRs() {
    return psrs;
  }

  void setPSRs(List<Psr>? psrs) {
    this.psrs = psrs;
  }

  List<WTaskType>? getTaskTypes() {
    return taskTypes;
  }

  void setTaskTypes(List<WTaskType>? taskTypes) {
    this.taskTypes = taskTypes;
  }

  bool isEmpty() {
    return outlets == null || outlets!.isEmpty || routes == null || routes!.isEmpty;
  }

  int? getTargetOutlets() {
    return targetOutlets;
  }

  void setTargetOutlets(int? targetOutlets) {
    this.targetOutlets = targetOutlets;
  }
}
