import 'package:ct484_project/ui/cart/cart_screen.dart';
import 'package:ct484_project/ui/products/edit_product_screen.dart';
import 'package:ct484_project/ui/products/product_detail_screen.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:ct484_project/ui/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 48, 43, 55),
            elevation: 4,
            // shadowColor: black.shadow,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomeScreen(),
        routes: {
          CartScreen.routeName: (context) => const SafeArea(child: CartScreen()),
          // ProductsScreen.routeName: (context) => const SafeArea(child: ProductsScreen()),
        },

        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailScreen.routeName) {
            final idProduct = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return SafeArea(
                  child: ProductDetailScreen(
                    ProductsManager().findById(idProduct)!,
                  )
                );
              }
            );
          }
          if (settings.name == EditProductScreen.routerName) {
            final idProduct = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return SafeArea(
                  child: EditProductScreen(
                    idProduct != null ? context.read<ProductsManager>().findById(idProduct) : null,
                  )
                );
              }
            );
          }
          return null;
        },
      ),
    );
  }
}
