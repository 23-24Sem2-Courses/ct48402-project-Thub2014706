import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/products/edit_product_screen.dart';
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
    return ListTile(
      title: Text(product.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.images[0]),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            DeleteProductButton(
              onPressed: () {
                // context.read<ProductsManager>().deleteProduct(product.id!);
                // ScaffoldMessenger.of(context)
                //   ..hideCurrentSnackBar()
                //   ..showSnackBar(
                //     const SnackBar(
                //       content: Text(
                //         'Xóa thành công!',
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   );
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
      icon: const Icon(Icons.favorite),
      color: Colors.red,
    );
  }
}