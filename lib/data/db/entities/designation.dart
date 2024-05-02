import 'package:json_annotation/json_annotation.dart';

part 'designation.g.dart';

@JsonSerializable()
class Designation {

  @JsonKey(name: 'designationId')
  final int? designationId;

  @JsonKey(name: 'designationValue')
  final String? designationValue;

  Designation(this.designationId, this.designationValue);

  factory Designation.fromJson(Map<String, dynamic> json) =>
      _$DesignationFromJson(json);

  Map<String, dynamic> toJson() => _$DesignationToJson(this);
}
