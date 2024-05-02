// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WTask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WTask _$WTaskFromJson(Map<String, dynamic> json) => WTask(
      taskId: json['taskId'] as int,
      taskName: json['taskName'] as String?,
      taskDate: json['taskDate'] as String?,
      completedDate: json['completedDate'] as String?,
      status: json['status'] as String?,
      outletId: json['outletId'] as int?,
    );

Map<String, dynamic> _$WTaskToJson(WTask instance) => <String, dynamic>{
      'taskId': instance.taskId,
      'taskName': instance.taskName,
      'taskDate': instance.taskDate,
      'completedDate': instance.completedDate,
      'status': instance.status,
      'outletId': instance.outletId,
    };
