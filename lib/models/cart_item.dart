import 'package:hive/hive.dart';
import 'package:mini_shop_app/models/product.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 1)
class CartItem {
  @HiveField(0)
  final Product product;
  @HiveField(1)
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}