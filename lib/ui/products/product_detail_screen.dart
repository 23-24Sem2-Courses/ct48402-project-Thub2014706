import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/auth/auth_screen.dart';
import 'package:ct484_project/ui/cart/cart_manager.dart';
import 'package:ct484_project/ui/cart/cart_screen.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:ct484_project/ui/products/top_right_badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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

  final _favorite = ValueNotifier<bool?>(false);
  int _quantity = 1;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _updateFavoriteStatus();
  }

  void _updateFavoriteStatus() async {
    bool? favoriteStatus = await context.read<ProductsManager>().isFavorite(widget.product.id!);
    _favorite.value = favoriteStatus;
  }

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,###", "vi_VN");
    final TextEditingController quantityController = TextEditingController(text: '$_quantity');
    Product product = widget.product;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer<CartManager>(
            builder: (context, cartManager, child) {
              return TopRightBadge(
                data: cartManager.itemCount,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CartScreen.routeName,
                    );
                  },
                ),
              );
            },
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
                '${f.format(product.price).toString()}đ',
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
                    child: Consumer<AuthManager> (
                      builder: (context, authManager, child) {
                        return authManager.isAuth 
                          ? ValueListenableBuilder<bool?>(
                            valueListenable: _favorite,
                            builder: (context, isFavorite, child) {
                              print(_favorite.value);
                              return IconButton(
                                icon: _favorite.value == false 
                                  ? const Icon(Icons.favorite_border) 
                                  : const Icon(Icons.favorite, color: Colors.red,),
                                iconSize: 30,
                                onPressed: () {
                                  if (isFavorite == false) {
                                    context.read<ProductsManager>().addFavorite(widget.product.id!);
                                    setState(() {
                                      _favorite.value = true;
                                    });
                                    ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(content: Text('Thêm thành công vào danh sách Yêu thích!', textAlign: TextAlign.center,))
                                    );
                                  } else {
                                    context.read<ProductsManager>().deleteFavorite(widget.product.id!);
                                    setState(() {
                                      _favorite.value = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(content: Text('Đã xóa khỏi danh sách Yêu thích!', textAlign: TextAlign.center,))
                                    );
                                  }
                                },
                              );
                            },
                          ) 
                          : IconButton(
                            icon: Icon(Icons.favorite_border), 
                            iconSize: 30,
                            onPressed: () {
                              // Show dialog to prompt user to login
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: const Text('Bạn cần đăng nhập để sử dụng chức năng này.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); 
                                      },
                                      child: const Text('Đóng'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          AuthScreen.routeName,
                                        );
                                      },
                                      child: const Text('Đăng nhập'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      )
                    
                    ),
                ],
              )
            ),

            
            Container(
              color: const Color.fromARGB(255, 241, 241, 241),
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
                            final authManager = context.read<AuthManager>();
                            final cartManager = context.read<CartManager>();
                            if (authManager.isAuth) {
                              cartManager.addCart(product, _quantity);
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pop(context);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Thành công!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  backgroundColor: Color.fromARGB(255, 255, 255, 255), // Màu nền của SnackBar
                                  duration: Duration(seconds: 2), // Thời gian hiển thị
                                  behavior: SnackBarBehavior.floating, // Hiển thị ở giữa màn hình
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: const Text('Bạn cần đăng nhập để sử dụng chức năng này.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); 
                                      },
                                      child: const Text('Đóng'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          AuthScreen.routeName,
                                        );
                                      },
                                      child: const Text('Đăng nhập'),
                                    ),
                                  ],
                                ),
                              );
                            }
                            
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

