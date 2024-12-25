import 'package:bs23_boilerplate/app/component/button_component.dart';
import 'package:bs23_boilerplate/app/component/text_component.dart';
import 'package:bs23_boilerplate/app/models/product/product_info.dart';
import 'package:bs23_boilerplate/app/utils/constants.dart';
import 'package:bs23_boilerplate/app/utils/style.dart';
import 'package:bs23_boilerplate/app/views/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/image_view_component.dart';
import '../controllers/cart_controller.dart';
import '../utils/utils.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductInfo product;

   ProductDetailsScreen({super.key, required this.product});
  final  cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextComponent(product.productName!,fontSize:titleFontSize,),       actions: [
          // Cart Icon with Count Badge
          Obx(() => Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                     Get.to(()=>CartScreen(),transition: rightToLeft);
                    },
                  ),
                  if (cartController.cartCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${cartController.cartCount}',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
                ),
                ),]
                ),
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
              TextComponent(
                product.productName!,
                fontSize: titleFontSize,
                fontWeight: titleFontWeight,
             
              ),
              const SizedBox(height: 8),
              // Product Price
              TextComponent(
                'BDT ${product.price!.toStringAsFixed(2)}',
                fontSize: textFontSize,
                fontWeight: titleFontWeight,
                color: kGreenColor,
           
              ),
              const SizedBox(height: 16),
              // Product Description
              const TextComponent(
                'Description',
                   fontSize: textFontSize,
                fontWeight: titleFontWeight,
              
              ),
              const SizedBox(height: 8),
              TextComponent(
                product.details!,
             fontSize: textSmallFontSize,
              ),
              const SizedBox(height: 24),
                   // Quantity and Add to Cart Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const TextComponent("Ouantity:"),
                Row(
                  children: [

                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        cartController.removeFromCart(product);
                      },
                    ),
                    Obx(() {
                      final quantity = cartController.getProductQuantity(product);
                      return Text(
                        '$quantity',
                        
                      );
                    }),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        cartController.addToCart(product);
                      },
                    ),
                  ],
                ),
      
              ],
            ),
              ButtonComponent(onPressed: (){
                  cartController.addToCart(product);
              },text: "Add to cart",)
            ],
          ),
        ),
      ),
    );
  }
}
