import 'package:ct484_project/models/cart_item.dart';
import 'package:ct484_project/ui/cart/cart_manager.dart';
import 'package:ct484_project/ui/shared/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard(
    this.cartItem, {
    super.key,
  });
  

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Text(
          'Xóa',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss:(direction) {
        return showConfirmDialog(context, 'Bạn muốn xóa sản phẩm này?');
      },
      onDismissed: (direction) {
        context.read<CartManager>().deleteCart(cartItem.id!);
      },
      child: ItemInfoCard(cartItem),
    );
  }
}

class ItemInfoCard extends StatelessWidget {

  final CartItem cartItem;

  const ItemInfoCard(
    this.cartItem, {
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              cartItem.image,
              fit: BoxFit.cover,
              width: 85,
              height: 85,
            ),
          ),
          title: Text(
            cartItem.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            '${cartItem.price.toString().replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]}.',
            )}đ', 
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            'x${cartItem.quantity}',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
    
  }
}