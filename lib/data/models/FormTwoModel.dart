import 'package:json_annotation/json_annotation.dart';

part 'FormTwoModel.g.dart';

@JsonSerializable()
class FormTwoModel {
  String? ownerName;
  String? ownerFatherName;
  String? cnic;
  String? cellNo;
  String? contactPerson1;
  String? contactPerson1CellNum;
  String? contactPerson2;
  String? contactPerson2CellNum;
  String? contactPerson3;
  String? contactPerson3CellNum;
  String? frontImage;
  String? backImage;
  String? signature;
  String? outletImage;

  FormTwoModel({
    this.ownerName,
    this.ownerFatherName,
    this.cnic,
    this.cellNo,
    this.contactPerson1,
    this.contactPerson1CellNum,
    this.contactPerson2,
    this.contactPerson2CellNum,
    this.contactPerson3,
    this.contactPerson3CellNum,
    this.frontImage,
    this.backImage,
    this.signature,
    this.outletImage,
  });

  factory FormTwoModel.fromJson(Map<String, dynamic> json) =>
      _$FormTwoModelFromJson(json);

  Map<String, dynamic> toJson() => _$FormTwoModelToJson(this);
}
