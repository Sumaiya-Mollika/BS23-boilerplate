import 'package:bs23_boilerplate/app/models/product/product_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/image_view_component.dart';
import '../utils/utils.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductInfo product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.productName!)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ImageViewComponent(
                imageUrl: product.imageUrl!,
                isNetworkAssetSvg: getFileType(product.imageUrl!),
                isLocalAsset: false,
                boxFit: BoxFit.contain,
                width: double.infinity,
                height: 250,
              ),
              const SizedBox(height: 16),
              // Product Name
              Text(
                product.productName!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Product Price
              Text(
                'BDT ${product.price!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Product Description
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.details!,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 24),
              // Add to Cart Button
            ],
          ),
        ),
      ),
    );
  }
}
