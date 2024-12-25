import 'package:bs23_boilerplate/app/component/product/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 400 ? 3 : 2;

    return Obx(() {
      if (productController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.75,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: productController.productList.length,
        itemBuilder: (context, index) {
          final product = productController.productList[index];
          return ProductCard(product: product!);
        },
      );
    });
  }
}
