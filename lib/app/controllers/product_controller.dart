import 'package:bs23_boilerplate/app/models/product/product_info.dart';
import 'package:bs23_boilerplate/app/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  late final ProductService _productService;
  final productList = RxList<ProductInfo?>([]);
  final isLoading = RxBool(false);

  @override
  void onInit() {
    _productService = ProductService();
    getAllProducts();
    super.onInit();
  }

  getAllProducts() {
    Map<String, dynamic>? param = {};
    _productService.getProducts(param, (response, error) async {
      if (response != null) {
        productList.addAll(response.payload!);
      }
    });
    productList.value = [
      ProductInfo(
          id: '1',
          productName: 'Wireless Noise-Cancelling Headphones',
          price: 1999,
          imageUrl:
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MQTQ3?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1687660671363',
          details:
              "Experience the ultimate in sound quality with these wireless noise-canceling headphones. Featuring advanced acoustic technology, these headphones deliver immersive, high-fidelity audio while effectively eliminating background noise. The lightweight, ergonomic design ensures all-day comfort, making them perfect for travel, work, or relaxation."),
      ProductInfo(
          id: '2',
          productName: 'Product 2',
          price: 2999,
          imageUrl: 'https://via.placeholder.com/150',
          details: ""),
      ProductInfo(
          id: '3',
          productName: 'Product 3',
          price: 3999,
          imageUrl: 'https://via.placeholder.com/150',
          details: ""),
    ];
  }
}
