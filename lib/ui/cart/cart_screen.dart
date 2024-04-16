import 'package:ct484_project/ui/cart/cart_item_card.dart';
import 'package:ct484_project/ui/cart/cart_manager.dart';
import 'package:ct484_project/ui/orders/order_manager.dart';
import 'package:ct484_project/ui/orders/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,###", "vi_VN");
    final cart = context.read<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng', style: TextStyle(color: Colors.white),),
      ),
      body: cart.totalAmount != 0 ?
        FutureBuilder(
          future: cart.fetchCart(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  Expanded(child: CartItemList(cart)),
                ],
              );
            }
            
          },
        ) : Container(
          alignment: Alignment.center,
          child: const Text('Không có sản phẩm nào trong giỏ hàng!', style: TextStyle(fontSize: 15),),
        ),
      
      bottomNavigationBar: Consumer<CartManager>(
        builder: (context, cartManager, child) {
          return cartManager.totalAmount != 0 ?
            Container(
              height: 60,
              color: Colors.black12,
              child: Row(  
                mainAxisAlignment: MainAxisAlignment.end,       
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Tổng thanh toán',
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                      Text(
                        '${f.format(cart.totalAmount).toString()}đ',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrdersManager>().addOrder(cart.items, cart.totalAmount);
                      context.read<CartManager>().deleteAll();
                      Navigator.of(context).pushNamed(
                        OrdersScreen.routeName,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(18),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )
                    ),
                    child: const Text(
                      'Mua hàng',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                  ) 
                ],
              )
            ) : SizedBox();
        },
      )
      
    );
  }
}

class CartItemList extends StatelessWidget {
  final CartManager cartManager;

  const CartItemList(
    this.cartManager, {
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: cartManager.items.map((item) => CartItemCard(item)).toList(),      
    );
  }
}

