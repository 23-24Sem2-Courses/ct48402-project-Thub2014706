import 'package:ct484_project/models/product.dart';
import 'package:flutter/material.dart';

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
                print('edit');
              },
            ),
            DeleteProductButton(
              onPressed: () {
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