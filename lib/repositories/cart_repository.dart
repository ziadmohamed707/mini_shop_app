import 'package:hive/hive.dart';
import 'package:mini_shop_app/models/product.dart';
import '../models/cart_item.dart';

class CartRepository {
  final Box<CartItem> _cartBox;

  CartRepository() : _cartBox = Hive.box<CartItem>('cart');

  void addToCart(Product product) {
    final existingItem = _cartBox.get(product.id);
    if (existingItem != null) {
      existingItem.quantity++;
      _cartBox.put(product.id, existingItem);
    } else {
      final cartItem = CartItem(product: product);
      _cartBox.put(product.id, cartItem);
    }
  }

  void removeFromCart(int productId) {
    _cartBox.delete(productId);
  }

  Future<List<CartItem>> getCartItems() async {
    return _cartBox.values.toList();
  }

  double getTotalPrice() {
    return _cartBox.values.fold(0.0, (total, item) => total + (item.product.price * item.quantity));
  }
}