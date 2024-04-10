import 'package:ct484_project/ui/products/product_list_tile.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  static const routeName = '/manager-products';

  const ProductsScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // const Image(
        //         image: AssetImage('assets/images/logo.jpg'),
        //         width: 40,
        //         height: 40,
        //         fit: BoxFit.cover, 
        //         alignment: Alignment.center,
        //       ),
        title: const Text(
          'Quản lý sản phẩm', 
          style: TextStyle(color: Color.fromARGB(255, 245, 245, 245)),
        ),
        actions: <Widget>[
          AddProductButton(
            onPressed: () {
              print('add');
            },
          )
        ],
      ),
      body: const ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();

    return ListView.builder(
      itemCount: productsManager.itemCount,
      itemBuilder: (ctx, i) => Column(
        children: [
          ProductListTile(
            productsManager.items[i],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed, 
      icon: const Icon(Icons.add, color: Colors.white,),
    );
  }
}