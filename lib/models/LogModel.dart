import 'package:json_annotation/json_annotation.dart';

import 'BaseResponse.dart';

part 'generated_models/log_model.g.dart';

@JsonSerializable()
class LogModel extends BaseResponse {
  @JsonKey(name: 'distributionId')
  int? _distributionId;

  @JsonKey(name: 'operationTypeId')
  int? _operationTypeId;

  @JsonKey(name: 'salesmanId')
  int? _salesmanId;

  @JsonKey(name: 'startDay')
  int? _startDay;

  LogModel();

  int? get distributionId => _distributionId;

  set distributionId(int? value) {
    _distributionId = value;
  }

  int? get operationTypeId => _operationTypeId;

  set operationTypeId(int? value) {
    _operationTypeId = value;
  }

  int? get salesmanId => _salesmanId;

  set salesmanId(int? value) {
    _salesmanId = value;
  }

  int? get startDay => _startDay;

  set startDay(int? value) {
    _startDay = value;
  }

  factory LogModel.fromJson(Map<String, dynamic> json) =>
      _$LogModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogModelToJson(this);
}
