import 'package:json_annotation/json_annotation.dart';

import '../../../utils/Utils.dart';

part 'pack_mapping.g.dart';

@JsonSerializable()
class PackMapping {
  final int id;

  @JsonKey(name: 'packId')
  final int? packId;

  @JsonKey(name: 'packName')
  final String? packName;

  @JsonKey(name: 'companyId')
  final int? companyId;

  @JsonKey(name: 'companyName')
  final String? companyName;

  @JsonKey(name: 'skuId')
  final String? skuId;

  @JsonKey(name: 'skuName')
  final String? skuName;

  @JsonKey(name: "isCold",toJson: boolToInt)
  final bool? isCold;

  @JsonKey(name: "isWarm",toJson: boolToInt)
  final bool? isWarm;


  final bool? isLowStock;

  PackMapping({
    required this.id,
    this.packId,
    this.packName,
    this.companyId,
    this.companyName,
    this.skuId,
    this.skuName,
    this.isCold,
    this.isWarm,
    this.isLowStock,
  });

  factory PackMapping.fromJson(Map<String, dynamic> json) =>
      _$PackMappingFromJson(json);

  Map<String, dynamic> toJson() => _$PackMappingToJson(this);
}
