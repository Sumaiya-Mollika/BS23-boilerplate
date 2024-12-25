import 'dart:convert';
import 'package:bs23_boilerplate/app/models/product/product_info.dart';
import 'package:bs23_boilerplate/app/utils/constants.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  // Using a map to store product quantities
  var cartItems = <ProductInfo, int>{}.obs;



  @override
  void onInit() {
    super.onInit();
    _loadCartData();
  }

  // Load cart data from secure storage
  Future<void> _loadCartData() async {
    String? cartData = await storage.read(key: StorageKeys.keyCartItems);
    if (cartData != null) {
      List<dynamic> decodedData = jsonDecode(cartData);
      cartItems.clear();
      for (var item in decodedData) {
        ProductInfo product = ProductInfo.fromJson(item['product']);
        cartItems[product] = item['quantity'];
      }
    }
  }

  // Save cart data to secure storage
  Future<void> _saveCartData() async {
    List<Map<String, dynamic>> encodedData = cartItems.entries
        .map((entry) => {
              'product': entry.key.toJson(),
              'quantity': entry.value,
            })
        .toList();
    String encodedCartData = jsonEncode(encodedData);
    await storage.write(key: StorageKeys.keyCartItems, value: encodedCartData);
  }

  // Add product to cart (or update quantity if already added)
  void addToCart(ProductInfo product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
    _saveCartData(); // Save cart after adding
  }

  // Remove product from cart (or decrease quantity)
  void removeFromCart(ProductInfo product) {
    if (cartItems.containsKey(product)) {
      if (cartItems[product]! > 1) {
        cartItems[product] = cartItems[product]! - 1;
      } else {
        cartItems.remove(product);
      }
    }
    _saveCartData(); // Save cart after removing
  }

  // Get total cart items count
  int get cartCount => cartItems.values.fold(0, (sum, qty) => sum + qty);

  // Get product quantity for a specific product
  int getProductQuantity(ProductInfo product) {
    return cartItems[product] ?? 0;
  }

  // Get the total price of the cart
  double get totalPrice {
    return cartItems.entries
        .map((entry) {
          return (entry.key.price ?? 0.0) * entry.value;
        })
        .fold(0.0, (sum, price) => sum + price);
  }
}
