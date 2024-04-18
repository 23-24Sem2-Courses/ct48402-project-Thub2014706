import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/products/product_detail_screen.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteTile extends StatelessWidget {
  final Product product;
  const FavoriteTile(
    this.product, {
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: ListTile(
        title: Text(product.name),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.images[0]),
        ),
        trailing: Consumer<ProductsManager>(
          builder: (context, productManager, child) {
            return SizedBox(
              width: 100,
              child: DeleteProductButton(
                onPressed: () {
                  context.read<ProductsManager>().deleteFavorite(product.id!);
                },
              )
            );
          },
        )  
      ),
    );
    
  }
}

class DeleteProductButton extends StatelessWidget {
  const DeleteProductButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: const Icon(Icons.favorite),
      color: Colors.red,
    );
  }
}
