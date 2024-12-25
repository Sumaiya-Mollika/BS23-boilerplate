import 'package:bs23_boilerplate/app/models/product/product_info.dart';
import 'package:bs23_boilerplate/app/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  late final ProductService _productService;
  final productList = RxList<ProductInfo?>([]);

  @override
  void onInit() {
    _productService = ProductService();

    super.onInit();
  }

  getAllProducts() {
    Map<String, dynamic>? param = {};
    _productService.getProducts(param, (response, error) async {
      if (response != null) {
        productList.addAll(response.payload!);
      }
    });
  }
}
