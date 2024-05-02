import 'package:json_annotation/json_annotation.dart';

part 'task_type.g.dart';

@JsonSerializable()
class TaskType {
  @JsonKey(name: 'taskTypeId')
  final int? taskTypeId;

  @JsonKey(name: 'taskType')
  final String? taskType;

  TaskType({
    this.taskTypeId,
    this.taskType,
  });

  factory TaskType.fromJson(Map<String, dynamic> json) =>
      _$TaskTypeFromJson(json);

  Map<String, dynamic> toJson() => _$TaskTypeToJson(this);

  @override
  String toString() {
    return taskType ?? ''; // What to display in the Spinner list.
  }
}
