import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop_app/models/cart_item.dart';
import '../blocs/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartCubit, List<CartItem>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
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
    );
  }
}