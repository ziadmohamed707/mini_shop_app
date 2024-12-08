import 'package:bloc/bloc.dart';
import '../models/product.dart';
import '../repositories/product_repository.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super(ProductInitial()) {
    fetchProducts();
  }

  void fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await _productRepository.getAllProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to fetch products"));
    }
  }
}

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}