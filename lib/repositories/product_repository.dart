

import 'package:mini_shop_app/models/product.dart';
import 'package:mini_shop_app/services/api_service.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository(this.apiService);

  Future<List<Product>> getAllProducts() async {
    return await apiService.fetchProducts();
  }
}