import 'package:eds_survey/data/models/BaseResponse.dart';
import 'package:eds_survey/data/models/OutletModel.dart';
import 'package:eds_survey/data/models/Product.dart';
import 'package:eds_survey/main.dart';
import 'package:json_annotation/json_annotation.dart';

import '../db/entities/asset_entity.dart';
import '../db/entities/asset_missing_reason.dart';
import '../db/entities/designation.dart';
import '../db/entities/distribution.dart';
import '../db/entities/outlet.dart';
import '../db/entities/pack_mapping.dart';
import '../db/entities/route.dart';
import '../db/entities/task.dart';
import '../db/entities/task_type.dart';
import 'Configuration.dart';
import 'LookUpObject.dart';

part 'MainModel.g.dart';

@JsonSerializable()
class MainModel extends BaseResponse {
  static MainModel? mainModel;

  MainModel();

  MainModel getInstance() {
    mainModel ??= MainModel();

    return mainModel!;
  }

  @JsonKey(name: 'targetOutlets')
  int? targetOutlets;

  @JsonKey(name: 'outlets')
  List<OutletModel>? outlets;

  @JsonKey(name: 'routes')
  List<MRoute>? routes;

  @JsonKey(name: 'distributions')
  List<Distribution>? distributions;

  @JsonKey(name: 'designations')
  List<Designation>? designations;

  @JsonKey(name: 'tasks')
  List<Task>? tasks;

  @JsonKey(name: 'packMappings')
  List<PackMapping>? packMappings;

  @JsonKey(name: 'taskTypes')
  List<TaskType>? taskTypes;

  @JsonKey(name: 'assetMissingReasons')
  List<AssetMissingReason>? missingReasons;

  @JsonKey(name: 'outletAssets')
  List<AssetEntity>? outletAssets;

  @JsonKey(name: 'packages')
  List<LookUpObject>? packages;

  @JsonKey(name: 'brands')
  List<LookUpObject>? brands;

  @JsonKey(name: 'configuration')
  Configuration? configuration;

  @JsonKey(name: 'products')
  List<Product>? products;

  factory MainModel.fromJson(Map<String, dynamic> json) =>
      _$MainModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainModelToJson(this);

  bool isEmpty() {
    return outlets == null ||
        outlets!.isEmpty ||
        routes == null ||
        routes!.isEmpty;
  }
}
