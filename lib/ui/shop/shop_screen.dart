import 'package:ct484_project/models/product.dart';
import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:ct484_project/ui/cart/cart_manager.dart';
import 'package:ct484_project/ui/cart/cart_screen.dart';
import 'package:ct484_project/ui/products/product_grid_tile.dart';
import 'package:ct484_project/ui/products/products_grid.dart';
import 'package:ct484_project/ui/products/products_manager.dart';
import 'package:ct484_project/ui/products/top_right_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late Future<void> _fetchProducts;
  final _selectType = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts(_selectType.value);
    _selectType.addListener(() {
      _fetchProducts = context.read<ProductsManager>().fetchProducts(_selectType.value);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        actions: [
          Row(
            children: [
              const Image(
                image: AssetImage('assets/images/logo.png'),
                width: 40,
                height: 40,
                fit: BoxFit.cover, // Cách hình ảnh được căn chỉnh trong không gian được chỉ định
                alignment: Alignment.center, // Căn chỉnh hình ảnh trong không gian được chỉ định
              ),
              Container(
                width: 230,
                height: 35,
                margin: const EdgeInsets.only(left: 10), // margin để tạo khoảng cách giữa ô tìm kiếm và các phần tử khác
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20), 
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 83, 82, 82).withOpacity(0.5), // màu đổ bóng
                      spreadRadius: 2, // độ lan rộng của bóng
                      blurRadius: 5, // độ mờ của bóng
                      offset: const Offset(0, 3), // vị trí của bóng
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 9), // Đặt chiều cao cho `TextField`
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                color: Colors.white,
                onPressed: () {
                  // context.read<AuthManager>().logout();
                },
              ),
              Consumer<CartManager>(
                builder: (context, cartManager, child) {
                  return TopRightBadge(
                    data: cartManager.itemCount,
                    child: IconButton(
                      icon: const Icon(Icons.shopping_cart, color: Colors.white,),
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
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPromotionBanner(),
            _typeProduct(),
            FutureBuilder(
              future: _fetchProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    child: ValueListenableBuilder(
                      valueListenable: _selectType,
                      builder: (context, type, child) {
                        return Container(
                          child: ProductsGrid()
                        );
                      },
                    )                    
                  );                  
                }else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            )  
          ],
        ),
      )
      
          
    );
  }
  Widget _typeProduct() {
    List<String> items =  ['Moraine', 'Melissani', 'Sicily', 'Kashmir', 'Weimar'];
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Tất cả danh mục', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectType.value != item) {
                        _selectType.value = item;
                      } else {
                        _selectType.value = null;
                      }
                      // print(selectType);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: _selectType.value == item ? BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ) : null,
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/images/$item.png'),
                          height: 50,
                        ),
                        Text(item),
                      ],
                    ),
                  )
                  
                )            
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildPromotionBanner() {
    return Container(
      height: 150,
      child: FlutterCarousel(
        options: CarouselOptions(
          height: 150,
          aspectRatio: 16 / 9,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          controller: CarouselController(),
          pageSnapping: true,
          scrollDirection: Axis.horizontal, //chiều ngang
          pauseAutoPlayOnTouch: true,
          pauseAutoPlayOnManualNavigate: true,
          pauseAutoPlayInFiniteScroll: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          disableCenter: true,
          slideIndicator: CircularSlideIndicator(),
        ),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const  EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  // color: Colors.amber
                  image: DecorationImage(
                    image: AssetImage('assets/images/banner${i}.jpg'), 
                    fit: BoxFit.cover, 
                  )
                ),
                // child: Text('text $i', style: TextStyle(fontSize: 16.0),)
              );
            },
          );
        }).toList(),
      ),
    );
  }


}

