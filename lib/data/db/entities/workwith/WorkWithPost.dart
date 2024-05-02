import 'package:json_annotation/json_annotation.dart';

import '../../../../utils/Utils.dart';

part 'WorkWithPost.g.dart';

@JsonSerializable()
class WorkWithPost {
  @JsonKey(name: 'outletId')
  final int outletId;

  @JsonKey(name: 'synced', toJson: boolToInt)
  bool? synced;

  @JsonKey(name: 'data')
  String? data;

  WorkWithPost({
    required this.outletId,
    this.synced,
    this.data,
  });

  factory WorkWithPost.fromJson(Map<String, dynamic> json) =>
      _$WorkWithPostFromJson(json);

  Map<String, dynamic> toJson() => _$WorkWithPostToJson(this);

  bool getSynced() => synced ?? false;
}
