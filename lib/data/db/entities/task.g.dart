// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      taskId: json['taskId'] as int,
      taskName: json['taskName'] as String?,
      taskDate: json['taskDate'] as String?,
      outletId: json['outletId'] as int?,
      completedDate: json['completedDate'] as String?,
      status: json['status'] as String?,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) {
  Map<String, dynamic> data = {
    'taskId': instance.taskId,
    'taskName': instance.taskName,
    'taskDate': instance.taskDate,
    'outletId': instance.outletId,
    'completedDate': instance.completedDate,
    'status': instance.status,
    'remarks': instance.remarks,
  };

  data.removeWhere((key, value) => value == null);
  return data;
}
