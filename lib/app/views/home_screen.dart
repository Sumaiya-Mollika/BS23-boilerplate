import 'package:bs23_boilerplate/app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/product/product_grid.dart';
import '../component/text_component.dart';
import '../controllers/product_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextComponent(
          'Product List',
          fontWeight: titleFontWeight,
        ),
      ),
      body: const ProductGrid(),
    );
  }
}
