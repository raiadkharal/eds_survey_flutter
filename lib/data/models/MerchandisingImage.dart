import 'package:json_annotation/json_annotation.dart';

part 'MerchandisingImage.g.dart';

@JsonSerializable()
class MerchandisingImage {
  int? id;
  String? path;
  String? image;
  int? type;

  MerchandisingImage({
    this.id,
    this.path,
    this.image,
    this.type,
  });

  factory MerchandisingImage.fromJson(Map<String, dynamic> json) =>
      _$MerchandisingImageFromJson(json);

  Map<String, dynamic> toJson() => _$MerchandisingImageToJson(this);
}
