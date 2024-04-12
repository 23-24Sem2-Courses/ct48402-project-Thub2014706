import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/cart/cart_manager.dart';
import 'package:ct484_project/ui/cart/cart_screen.dart';
import 'package:ct484_project/ui/products/top_right_badge.dart';
import 'package:flutter/material.dart';
// import 'package:flushbar/flushbar.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';
  final Product product;

  const ProductDetailScreen (
    this.product, {
      super.key,
    }
  );

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final TextEditingController quantityController = TextEditingController(text: '$_quantity');
    Product product = widget.product;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TopRightBadge(
            data: CartManager().itemCount,
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  CartScreen.routeName,
                );
              },
            ),
          )        
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 320,
              width: double.infinity,
              child: Image.network(product.images[index], fit: BoxFit.cover,),               
            ),


            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,   
                children: [
                  for (int i = 0; i < product.images.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            index = i;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: i == index ? Color.fromARGB(255, 228, 91, 28) : Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Image.network(
                            product.images[i],
                            fit: BoxFit.cover,
                            height: 70,
                            width: 70,
                          ),
                        )
                      )                      
                    ),
                ],
              ),
            ),


            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ) ,   


            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),


            Container(
              color: const Color.fromARGB(255, 241, 241, 241), // Màu nền của SizedBox
              height: 18,
            ),


            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Row(
                children: [
                  const Text(
                    'Yêu thích',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Tooltip(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    message: 'Favorite',
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      iconSize: 30,
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(content: Text('Thêm thành công vào danh sách Yêu thích!', textAlign: TextAlign.center,))
                        );
                      },
                    ),
                  ),
                ],
              )
            ),

            
            Container(
              color: const Color.fromARGB(255, 241, 241, 241), // Màu nền của SizedBox
              height: 18,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: const Text(
                'Mô tả sản phẩm',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ),


            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: Text(
                product.information,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        color: const Color.fromARGB(255, 247, 167, 46),
        height: 60,
        // child: Tooltip(
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                _quantity = 1;
                quantityController.text = '$_quantity';
              });
              showModalBottomSheet(
                context: context,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                builder: (BuildContext context) {
                  return Container(
                    height: 150,
                    child: Column(
                      children: [
                        Row(   
                          mainAxisAlignment: MainAxisAlignment.end,                    
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, 
                              icon: const Icon(Icons.close, color: Color.fromARGB(255, 119, 119, 119)),
                            ),
                          ]
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          width: double.infinity,
                          child: Row(
                            children: [
                              const Text(
                                'Số lượng:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 130),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (_quantity > 1) _quantity--;
                                        quantityController.text = '$_quantity';
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: 30,
                                    child: Center(
                                      child: TextField(
                                        controller: quantityController,
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        enabled: false,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black
                                        ),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 3),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        _quantity++;
                                        quantityController.text = '$_quantity';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),                   
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.pop(context);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Thành công!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                backgroundColor: Color.fromARGB(255, 255, 255, 255), // Màu nền của SnackBar
                                duration: Duration(seconds: 2), // Thời gian hiển thị
                                behavior: SnackBarBehavior.floating, // Hiển thị ở giữa màn hình
                              ),
                            );
                          }, 
                          child: const Text(
                            'Thêm vào giỏ hàng',
                            style: TextStyle(color: Color.fromARGB(255, 197, 85, 41), fontSize: 20),
                          ),
                        )
                      ]
                    ),
                  );
                },
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40),
            ),
            icon: const Icon(Icons.shopping_cart, color: Color.fromARGB(255, 255, 255, 255), ),
            label: const Text(
              'Thêm vào giỏ hàng',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
            ),
          ),
        ),
    );
  }
}

