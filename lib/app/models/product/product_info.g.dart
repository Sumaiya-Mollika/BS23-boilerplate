// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) => ProductInfo(
      productName: json['productName'] as String?,
      id: json['id'] as String?,
      price: json['price'] as num?,
      details: json['details'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'id': instance.id,
      'price': instance.price,
      'details': instance.details,
      'imageUrl': instance.imageUrl,
    };
