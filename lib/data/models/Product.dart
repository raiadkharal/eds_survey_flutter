import 'package:json_annotation/json_annotation.dart';

part 'Product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'productId')
  final int? productId;

  @JsonKey(name: 'productName')
  final String? productName;

  @JsonKey(name: 'productPackageId')
  final int? productPackageId;

  Product({
    this.productId,
    this.productName,
    this.productPackageId,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
