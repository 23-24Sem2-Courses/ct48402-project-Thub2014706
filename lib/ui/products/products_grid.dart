import 'package:ct484_project/ui/products/product_grid_tile.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final productsManger = ProductsManager();
    final products = productsManger.items;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tất cả sản phẩm',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < products.length; i = i + 2) (
            Row(     
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                ProductGridTile(products[i]),
                const SizedBox(width: 20),
                ProductGridTile(products[i + 1]),
              ],
            )
          )
        ],
      ),
    );
  }
}