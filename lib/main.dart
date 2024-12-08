import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_shop_app/blocs/cart_cubit.dart';
import 'package:mini_shop_app/blocs/product_cubit.dart';
import 'package:mini_shop_app/models/product.dart';
import 'package:mini_shop_app/services/api_service.dart';
import 'repositories/cart_repository.dart';
import 'repositories/product_repository.dart';
import 'screens/cart_screen.dart';
import 'screens/product_list_screen.dart';
import 'models/cart_item.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cart');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ProductCubit(ProductRepository(ApiService()))),
        BlocProvider(create: (context) => CartCubit(CartRepository())),
      ],
      child: MaterialApp(
        title: 'Product Cart App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ProductListScreen(),
        routes: {
          '/cart': (context) => const CartScreen(),
        },
      ),
    );
  }
}
