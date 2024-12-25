
import 'package:bs23_boilerplate/app/component/text_component.dart';
import 'package:bs23_boilerplate/app/utils/style.dart';
import 'package:bs23_boilerplate/app/views/cart_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  final cartController = Get.put(CartController());

CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextComponent("Cart",fontWeight: titleFontWeight,fontSize: titleFontSize,),

      ),
      body: Obx(() {
        if (cartController.cartCount == 0) {
          return const Center(
            child: TextComponent(
              "Your cart is empty!",
             
            ),
          );
        }

        return ListView.builder(
          itemCount:  cartController.cartItems.length,
          itemBuilder: (context, index) {
            var entry = cartController.cartItems.entries.toList()[index];
            var product = entry.key;
            var quantity = entry.value;

            return CartItemTile(
              product: product,
              quantity: quantity,
              onIncrease: () => cartController.addToCart(product),
              onDecrease: () => cartController.removeFromCart(product),
            );
          },
        );
      }),
    );
  }
}