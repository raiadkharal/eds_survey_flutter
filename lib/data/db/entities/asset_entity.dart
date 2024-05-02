import 'package:json_annotation/json_annotation.dart';

part 'asset_entity.g.dart';

@JsonSerializable()
class AssetEntity {

  @JsonKey(name: 'assetId')
  final int assetId;

  @JsonKey(name: 'outletId')
  final int? outletId;

  @JsonKey(name: 'assetNumber')
  final String? assetNumber;

  @JsonKey(name: 'assetType')
  final String? assetType;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'serialNumber')
  final String? serialNumber;

  AssetEntity(
    this.assetId,
    this.outletId,
    this.assetNumber,
    this.assetType,
    this.status,
    this.serialNumber,
  );

  factory AssetEntity.fromJson(Map<String, dynamic> json) =>
      _$AssetEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AssetEntityToJson(this);
}
