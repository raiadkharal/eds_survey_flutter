import 'package:json_annotation/json_annotation.dart';

part 'PJPModel.g.dart';

@JsonSerializable()
class PJPModel {
  int? key;
  String? value;

  PJPModel({this.key, this.value});

  PJPModel.secondary(this.key,this.value);

  factory PJPModel.fromJson(Map<String, dynamic> json) =>
      _$PJPModelFromJson(json);

  Map<String, dynamic> toJson() => _$PJPModelToJson(this);
}
