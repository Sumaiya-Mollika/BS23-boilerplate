import '../models/generic response/generic_api_list_response.dart';
import '../models/product/product_info.dart';
import '../network/api_client.dart';
import '../utils/constants.dart';

class ProductService {
  final ApiClient _apiClient = ApiClient.apiClient;
  static final ProductService _commonService = ProductService._internal();

  ProductService._internal();

  factory ProductService() {
    return _commonService;
  }

  void getProducts(Map<String, dynamic>? params,
      ResponseCallback<GenericListResponse<ProductInfo>?, String?> callback) {
    _apiClient.getRequest("url", params, (response, error) {
      if (response != null) {
        callback(
            GenericListResponse.fromJson(
                response, (data) => ProductInfo.fromJson(data)),
            null);
      } else {
        callback(null, error);
      }
    });
  }
}
