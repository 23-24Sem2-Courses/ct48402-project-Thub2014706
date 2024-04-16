import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/products/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile (
    this.product, {
      super.key,
    }
  );

  final Product product;

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,###", "vi_VN");
    return Container(
      width: 170,
      child: Card(
        color: Colors.white,      
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5, //do bong
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: product.id,
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.images[0],
                  fit: BoxFit.cover,
                  width: 200,
                  height: 140, 
                ),
                const SizedBox(height: 8),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${f.format(product.price).toString()}đ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}