import 'package:bs23_boilerplate/app/models/product/product_info.dart';
import 'package:get/get.dart';


class CartController extends GetxController {
  // Using a map to store product quantities
  var cartItems = <ProductInfo, int>{}.obs;

  // Add product to cart (or update quantity if already added)
  void addToCart(ProductInfo product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
    } else {
      cartItems[product] = 1;
    }
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
  }

  // Get total cart items count
  int get cartCount => cartItems.values.fold(0, (sum, qty) => sum + qty);
  int getProductQuantity(ProductInfo product) {
    return cartItems[product] ?? 0;
  }
  // Get the total price of the cart
  double get totalPrice => cartItems.entries
      .map((entry) => entry.key.price! * entry.value)
      .fold(0.0, (sum, price) => sum + price);
}
