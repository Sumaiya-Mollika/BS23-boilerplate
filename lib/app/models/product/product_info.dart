import 'package:json_annotation/json_annotation.dart';

part 'product_info.g.dart';

@JsonSerializable()
class ProductInfo {
  String? productName;
  String? id;
  num? price;
  String? details;
  String? imageUrl;

  ProductInfo(
      {this.productName, this.id, this.price, this.details, this.imageUrl});
  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);

   Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
}
