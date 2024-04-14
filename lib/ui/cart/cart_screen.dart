import 'package:ct484_project/ui/cart/cart_item_card.dart';
import 'package:ct484_project/ui/cart/cart_manager.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cart = CartManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10,),
          Expanded(child: CartItemList(cart)),
        ],
      ),
      bottomNavigationBar: Container(
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
                  '${cart.totalAmount.toString().replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]}.',
                )}đ',
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


// import 'package:ct484_project/ui/cart/cart_item_card.dart';
// import 'package:ct484_project/ui/cart/cart_manager.dart';
// import 'package:flutter/material.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cart = context.watch<CartManager>();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Cart'),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: CartItemList(cart),)
//         ],
//       ),
//     );
//   }
// }

// class CartItemList extends StatelessWidget {
//   const CartItemList(
//     this.cartManager, {
//       Key? key,
//     }
//   ) : super(key: key);

//   final CartManager cartManager;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: cartManager.items.length,
//       itemBuilder: (context, index) {
//         final item = cartManager.items[index];
//         return ListTile(
//           title: Text(item.product.name),
//           subtitle: Text('Price: ${item.product.price.toString()}'),
//           // Thêm các thông tin khác về sản phẩm tại đây
//         );
//       },
//     );
//   }
// }
