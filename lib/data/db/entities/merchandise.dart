import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../models/MerchandisingImage.dart';

part 'merchandise.g.dart';

@JsonSerializable()
class Merchandise {
  @JsonKey(name: 'outletId')
  int? outletId;
  @JsonKey(name: 'merchandiseImages')
  List<MerchandisingImage>? merchandiseImages;

  Merchandise({
    this.outletId,
    this.merchandiseImages,
  });

  factory Merchandise.fromJson(Map<String, dynamic> json) =>
      _$MerchandiseFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandiseToJson(this);
}
