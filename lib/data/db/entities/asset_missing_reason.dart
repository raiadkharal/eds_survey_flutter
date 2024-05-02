
import 'package:json_annotation/json_annotation.dart';

part 'asset_missing_reason.g.dart';

@JsonSerializable()
class AssetMissingReason {

  @JsonKey(name: 'reasonId')
  final int? reasonId;

  @JsonKey(name: 'reasonText')
  final String? reasonText;

  AssetMissingReason(this.reasonId, this.reasonText);

  factory AssetMissingReason.fromJson(Map<String, dynamic> json) =>
      _$AssetMissingReasonFromJson(json);

  Map<String, dynamic> toJson() => _$AssetMissingReasonToJson(this);
}
