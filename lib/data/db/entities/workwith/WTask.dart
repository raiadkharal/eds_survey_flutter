
import 'package:json_annotation/json_annotation.dart';

part 'WTask.g.dart';

@JsonSerializable()
class WTask {
  @JsonKey(name: 'taskId')
  final int taskId;

  @JsonKey(name: 'taskName')
  final String? taskName;

  @JsonKey(name: 'taskDate')
  final String? taskDate;

  @JsonKey(name: 'completedDate')
  final String? completedDate;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'outletId')
  final int? outletId;

  WTask({
    required this.taskId,
    this.taskName,
    this.taskDate,
    this.completedDate,
    this.status,
    this.outletId,
  });

  factory WTask.fromJson(Map<String, dynamic> json) => _$WTaskFromJson(json);

  Map<String, dynamic> toJson() => _$WTaskToJson(this);
}
