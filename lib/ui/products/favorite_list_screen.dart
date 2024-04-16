import 'package:ct484_project/ui/products/edit_product_screen.dart';
import 'package:ct484_project/ui/products/favorite_tile.dart';
import 'package:ct484_project/ui/products/product_list_tile.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteListScreen extends StatelessWidget {
  static const routeName = '/list-favorite';

  const FavoriteListScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách yêu thích', 
          style: TextStyle(color: Color.fromARGB(255, 245, 245, 245)),
        ),
      ),
      body: FutureBuilder(
        future: context.read<ProductsManager>().fetchProducts(null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
              context.read<ProductsManager>().allFavorite(),
            child: const ProductList(),
          );
        },
      )    
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    // final productsManager = ProductsManager();

    return Consumer<ProductsManager>(
      builder: (context, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              FavoriteTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      }
    );   
  }
}
