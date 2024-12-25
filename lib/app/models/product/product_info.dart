import 'package:json_annotation/json_annotation.dart';

part 'product_info.g.dart';


@JsonSerializable()
class ProductInfo {
 String? productName;
  String? id;
  String? price;
  String? details;

  ProductInfo({this.productName, this.id, this.price, this.details});
  factory ProductInfo.fromJson(Map<String, dynamic> json) => _$ProductInfoFromJson(json);


}