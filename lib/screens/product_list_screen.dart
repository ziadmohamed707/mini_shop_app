import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_cubit.dart';
import '../screens/cart_screen.dart';
import 'product_details_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        title: const Text(
          'Products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          if (state is ProductLoaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center content vertically
                  children: [
                    Expanded(
                      child: Image.network(
                        product.image,
                        fit: BoxFit.contain,
                        height: 100,
                        width: 70,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        product.title,
                        textAlign: TextAlign.center,
                        maxLines: 1, // Limit to 1 line
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MediaQuery.of(context).size.width > 600 ? 14 : 12,
                        ),
                      ),
                    ),
                    Expanded(child: Text('\$${product.price.toString()}')),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                        child: const Text('View Details'),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
