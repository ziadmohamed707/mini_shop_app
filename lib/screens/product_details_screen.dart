import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_shop_app/models/product.dart';
import '../blocs/cart_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 130),
            Center(
              child: Image.network(
                product.image,
                height: 150,
              ),
            ),
            const SizedBox(height: 55),
            Text(product.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
            const SizedBox(height: 30),
            Container(
                alignment: Alignment.centerRight,
                child: Text('Price: \$${product.price.toString()}',style: const TextStyle(fontSize: 20),)),
            const SizedBox(height: 30),

            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 2),

            ElevatedButton(
              onPressed: () {
                context.read<CartCubit>().addToCart(product);
                Navigator.pop(context);
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
