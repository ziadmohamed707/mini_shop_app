import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop_app/models/cart_item.dart';
import '../blocs/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: BlocBuilder<CartCubit, List<CartItem>>(
              builder: (context, cartItems) {
                // Filter cart items based on search query
                final filteredItems = _searchQuery.isEmpty
                    ? cartItems
                    : cartItems.where((item) {
                  return item.product.title
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                }).toList();

                if (filteredItems.isEmpty) {
                  return const Center(child: Text('Your cart is empty'));
                }

                return ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = filteredItems[index];
                    return ListTile(
                      title: Text(cartItem.product.title),
                      subtitle: Text('\$${cartItem.product.price} x ${cartItem.quantity}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          context.read<CartCubit>().removeFromCart(cartItem.product.id);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildTotalPrice(context),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Search Products',
          border: OutlineInputBorder(),
        ),
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
      ),
    );
  }

  Widget _buildTotalPrice(BuildContext context) {
    return BlocBuilder<CartCubit, List<CartItem>>(
      builder: (context, cartItems) {
        double totalPrice = cartItems.fold(0, (sum, item) {
          return sum + (item.product.price * item.quantity);
        });

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Text(
            'Total: \$${totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}