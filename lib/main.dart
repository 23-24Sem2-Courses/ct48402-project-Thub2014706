import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/auth/auth_screen.dart';
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
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthManager(),
        )
      ],
      child: MaterialApp(
        title: 'TWOT WATCH',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 247, 167, 46),
            elevation: 4,
            // shadowColor: black.shadow,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 232, 201)),
          useMaterial3: true,
        ),
        home: HomeScreen(),
        routes: {
          CartScreen.routeName: (context) => const SafeArea(child: CartScreen()),
          AuthScreen.routeName: (context) => const SafeArea(child: AuthScreen()),
        },

        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailScreen.routeName) {
            final idProduct = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return SafeArea(
                  child: ProductDetailScreen(
                    context.read<ProductsManager>().findById(idProduct)!,
                  )
                );
              }
            );
          }
          if (settings.name == EditProductScreen.routerName) {
            final idProduct = settings.arguments as String?;
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
