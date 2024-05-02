import 'package:json_annotation/json_annotation.dart';

import '../db/entities/market_visit.dart';
import '../db/entities/workwith/WorkWithPost.dart';
import '../db/entities/workwith/WorkWithPre.dart';

part 'UploadProgressModel.g.dart';

@JsonSerializable()
class UploadProgressModel {
  String? uploadType;
  String? description;
  MarketVisit? marketVisit;
  WorkWithPre? workWithPre;
  WorkWithPost? workWithPost;


  UploadProgressModel({
    required this.uploadType,
    required this.description,
    this.marketVisit,
    this.workWithPre,
    this.workWithPost
  });

  UploadProgressModel.marketVisit({
    required this.uploadType,
    required this.description,
    this.marketVisit,
  });

  UploadProgressModel.workWithPre({
    required this.uploadType,
    required this.description,
    this.workWithPre,
  });

  UploadProgressModel.workWithPost({
    required this.uploadType,
    required this.description,
    this.workWithPost,
  });

  bool getSynced(){
    if(marketVisit!=null)return  marketVisit!.synced??false;
    if(workWithPre!=null)return workWithPre!.synced??false;
    if(workWithPost!=null) return workWithPost!.synced??false;
    return false;
  }



  factory UploadProgressModel.fromJson(Map<String, dynamic> json) =>
      _$UploadProgressModelFromJson(json);

  Map<String, dynamic> toJson() => _$UploadProgressModelToJson(this);
}
