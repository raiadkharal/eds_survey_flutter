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
      vpo_classification:
          (jsonDecode(json['vpo_classification']) as List<dynamic>?)
              ?.map((e) => LookUpDataObject.fromJson(e as Map<String, dynamic>))
              .toList(),
      trade_classification:
          (jsonDecode(json['trade_classification']) as List<dynamic>?)
              ?.map((e) => LookUpDataObject.fromJson(e as Map<String, dynamic>))
              .toList(),
      outlet_classification:
          (jsonDecode(json['outlet_classification']) as List<dynamic>?)
              ?.map((e) => LookUpDataObject.fromJson(e as Map<String, dynamic>))
              .toList(),
      channels: (jsonDecode(json['channels']) as List<dynamic>?)
          ?.map((e) => LookUpDataObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      market_types: (jsonDecode(json['market_types']) as List<dynamic>?)
          ?.map((e) => LookUpDataObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      cities: (jsonDecode(json['cities']) as List<dynamic>?)
          ?.map((e) => LookUpDataObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      outletTypes: (jsonDecode(json['outletTypes']) as List<dynamic>?)
          ?.map((e) => LookUpDataObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookUpDataToJson(LookUpData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packages': jsonEncode(instance.packages),
      'brands': jsonEncode(instance.brands),
      'products': jsonEncode(instance.products),
      'vpo_classification': jsonEncode(instance.vpo_classification),
      'trade_classification': jsonEncode(instance.trade_classification),
      'outlet_classification': jsonEncode(instance.outlet_classification),
      'channels': jsonEncode(instance.channels),
      'market_types': jsonEncode(instance.market_types),
      'cities': jsonEncode(instance.cities),
      'outletTypes': jsonEncode(instance.outletTypes),
    };
