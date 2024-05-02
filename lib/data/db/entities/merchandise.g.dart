// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchandise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Merchandise _$MerchandiseFromJson(Map<String, dynamic> json) => Merchandise(
      outletId: json['outletId'] as int?,
      merchandiseImages: (jsonDecode(json['merchandiseImages']) as List<dynamic>?)
          ?.map((e) => MerchandisingImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MerchandiseToJson(Merchandise instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'merchandiseImages': jsonEncode(instance.merchandiseImages),
    };
