// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'look_up_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookUpData _$LookUpDataFromJson(Map<String, dynamic> json) => LookUpData(
      id: json['id'] as int? ?? 0,
      packages: (jsonDecode(json['packages']) as List<dynamic>?)
          ?.map((e) => LookUpObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (jsonDecode(json['brands']) as List<dynamic>?)
          ?.map((e) => LookUpObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (jsonDecode(json['products']) as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookUpDataToJson(LookUpData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packages': jsonEncode(instance.packages),
      'brands': jsonEncode(instance.brands),
      'products': jsonEncode(instance.products),
    };
