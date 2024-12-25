import 'package:bs23_boilerplate/app/models/product/product_info.dart';
import 'package:bs23_boilerplate/app/utils/constants.dart';
import 'package:bs23_boilerplate/app/utils/style.dart';
import 'package:bs23_boilerplate/app/views/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../utils/utils.dart';
import '../image_view_component.dart';
import '../text_component.dart';

class ProductCard extends StatelessWidget {
  final ProductInfo product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(product: product),
            transition: rightToLeft);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Column(
          children: [
            Expanded(
                child: ImageViewComponent(
              imageUrl: product.imageUrl!,
              isNetworkAssetSvg: getFileType(product.imageUrl!),
              isLocalAsset: false,
              boxFit: BoxFit.cover,
              width: double.infinity,
              imageRadius: 15,
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                    product.productName!,
                    fontWeight: titleFontWeight,
                    fontSize: k14FontSize,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 4),
                  TextComponent(
                    'BDT ${product.price!.toStringAsFixed(2)}',
                    fontSize: k12FontSize,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
