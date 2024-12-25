import 'package:bs23_boilerplate/app/component/image_view_component.dart';
import 'package:bs23_boilerplate/app/component/text_component.dart';
import 'package:bs23_boilerplate/app/models/product/product_info.dart';
import 'package:bs23_boilerplate/app/utils/style.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CartItemTile extends StatelessWidget {
  final ProductInfo product;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemTile({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      leading: ImageViewComponent( width: 50, imageUrl: product.imageUrl!,isNetworkAssetSvg: getFileType(product.imageUrl!),),
      title: TextComponent(product.productName!),
      subtitle: TextComponent("BDT ${product.price!.toStringAsFixed(2)} x $quantity",fontSize: k14FontSize,),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: onDecrease,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onIncrease,
          ),
        ],
      ),
    );
  }
}