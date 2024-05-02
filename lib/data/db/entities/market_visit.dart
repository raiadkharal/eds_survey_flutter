import 'package:json_annotation/json_annotation.dart';

import '../../../utils/Utils.dart';

part 'market_visit.g.dart';

@JsonSerializable()
class MarketVisit {
  @JsonKey(name: 'outletId')
  final int outletId;

  @JsonKey(name: "synced", toJson: boolToInt)
  bool? synced;

  String? data;

  MarketVisit(this.outletId, this.synced, this.data);

  bool getSynced() => synced ?? false;

  factory MarketVisit.fromJson(Map<String, dynamic> json) =>
      _$MarketVisitFromJson(json);

  Map<String, dynamic> toJson() => _$MarketVisitToJson(this);
}
