

import 'package:ct484_project/ui/orders/order_item_card.dart';
import 'package:ct484_project/ui/orders/order_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersManager = context.read<OrdersManager>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng của bạn', style: TextStyle(color: Colors.white),),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).pushNamed('/');
        //   },
        // ),
      ),
      body: FutureBuilder(
        future: ordersManager.fetchOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: ordersManager.orderCount,
              itemBuilder: (ctx, i) =>
                OrderItemCard(ordersManager.orders[i]),
            );
          }
        },
      ),
    );
  }
}
