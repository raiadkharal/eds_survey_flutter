import 'package:json_annotation/json_annotation.dart';

part 'WTaskType.g.dart';

@JsonSerializable()
class WTaskType {
  @JsonKey(name: 'taskTypeId')
  final int taskTypeId;

  @JsonKey(name: 'taskType')
  final String? taskType;

  WTaskType({
    required this.taskTypeId,
    this.taskType,
  });

  factory WTaskType.fromJson(Map<String, dynamic> json) =>
      _$WTaskTypeFromJson(json);

  Map<String, dynamic> toJson() => _$WTaskTypeToJson(this);
}
