import 'package:json_annotation/json_annotation.dart';

part 'Image.g.dart';

@JsonSerializable()
class Image {
  String? image;

  Image(this.image);

  String? getImage() {
    return image;
  }

  void setImage(String? image) {
    this.image = image;
  }

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
