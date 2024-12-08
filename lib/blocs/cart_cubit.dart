import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/cart_repository.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartCubit extends Cubit<List<CartItem>> {
  final CartRepository _cartRepository;

  CartCubit(this._cartRepository) : super([]);

  void loadCart() async {
    final items = await _cartRepository.getCartItems();
    emit(items);
  }

  void addToCart(Product product) async {
    _cartRepository.addToCart(product);
    loadCart();
  }

  void removeFromCart(int id) async {
    _cartRepository.removeFromCart(id);
    loadCart();
  }

  double getTotalPrice() {
    return _cartRepository.getTotalPrice();
  }
}