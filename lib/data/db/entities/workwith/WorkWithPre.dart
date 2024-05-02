// WorkWithPre.g.dart

import 'package:json_annotation/json_annotation.dart';

import '../../../../utils/Utils.dart';

part 'WorkWithPre.g.dart';

@JsonSerializable()
class WorkWithPre {
  @JsonKey(name: 'routeId')
  int routeId;

  @JsonKey(name: 'psrId')
  int psrId;

  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'synced', toJson: boolToInt)
  bool? synced;

  @JsonKey(name: 'data')
  final String? data;

  WorkWithPre({
    required this.routeId,
    required this.psrId,
    this.outletId,
    this.synced,
    this.data,
  });

  bool getSynced() => synced ?? false;

  factory WorkWithPre.fromJson(Map<String, dynamic> json) =>
      _$WorkWithPreFromJson(json);

  Map<String, dynamic> toJson() => _$WorkWithPreToJson(this);
}
