import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/products/edit_product_screen.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  const ProductListTile(
    this.product, {
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.images[0]),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            EditProductButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routerName,
                  arguments: product.id
                );
              },
            ),
            DeleteProductButton(
              onPressed: () {
                context.read<ProductsManager>().deleteProduct(product.id!);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'delete',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
              },
            )
          ],
        ),
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
      icon: const Icon(Icons.delete),
      color: Colors.red,
    );
  }
}

class EditProductButton extends StatelessWidget {
  const EditProductButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: const Icon(Icons.edit),
      color: Colors.green,
    );
  }
}