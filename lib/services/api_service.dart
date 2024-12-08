import 'package:dio/dio.dart';
import 'package:mini_shop_app/models/product.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');
      return (response.data as List).map((data) => Product.fromJson(data)).toList();
    } catch (_) {
      throw Exception('Failed to load products');
    }
  }
}